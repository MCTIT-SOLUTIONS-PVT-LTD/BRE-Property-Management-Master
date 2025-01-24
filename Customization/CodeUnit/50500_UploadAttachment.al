codeunit 50500 UploadAttachment
{

    procedure UploadAttachment(RecordRef: RecordRef; DocumentName: Text; No: Text; FieldName: Text; TableName: Text): Text
    var
        FileManagement: Codeunit "File Management";
        InStream: InStream;
        OutStream: OutStream; // For writing to the TempBlob
        TempBlob: Codeunit "Temp Blob";
        DocumentAttachment: Record "Document Attachment"; // Assuming this is the table for attached documents
        FileName: Text[250];
        FileSize: Decimal;
        FileExtension: Text[10];
        ValidFormats: List of [Text];
        FieldRef: FieldRef;
        MIMEType: Text[250];

        SystemIdFieldNo: Integer;
    begin
        // Define valid file formats 
        ValidFormats.Add('.pdf');
        ValidFormats.Add('.docx');
        ValidFormats.Add('.jpg');
        ValidFormats.Add('.jpeg');
        // Open the file dialog and get the file selected by the user
        if UploadIntoStream('Select a Document', '', '(*.pdf, *.docx,*.jpeg, *.jpg)|*.pdf;*.docx;*.jpeg;*.jpg', FileName, InStream) then begin
            // Save the document to a temporary blob
            // FileExtension := LowerCase(CopyStr(FileName, StrLen(FileName) - 3, 4));
            FileExtension := LowerCase(CopyStr(FileName, StrPos(FileName, '.'), StrLen(FileName) - StrPos(FileName, '.') + 1));
            if not ValidFormats.Contains(FileExtension) then
                Error('Unsupported file format. Please upload PDF, DOCX, JPEG or JPG.');

            // ** Validate File Size (10MB = 10 * 1024 * 1024 bytes) **
            FileSize := InStream.Length / 1024 / 1024; // Convert to MB
            if FileSize > 5 then
                Error('File is too large. Maximum size allowed is 5MB.');
            // Retrieve MIME type
            MIMEType := GetMimeTypeFromFileName(FileName);
            // ** Proceed with saving the document **
            TempBlob.CreateOutStream(OutStream);

            CopyStream(OutStream, InStream); // Copy file content to TempBlob
                                             // Now save the document information to the attached document table
            DocumentAttachment.Init();
            // DocumentAttachment."Table ID" := DATABASE::Item; // Table ID for the Item table
            DocumentAttachment."No." := No; // Item Number
                                            // DocumentAttachment."File Name" := FileName;

            // RecordRef.GetTABLE(Item); // Initialize RecordRef for Item
            // RecordRef.GET(Item.RecordId);

            TempBlob.CreateInStream(InStream);

            // Use the appropriate field for storing the blob data
            // DocumentAttachment.SetBlobFromStream(InStream); // Use SetBlobFromStream to set the document blob
            DocumentAttachment.SaveAttachmentFromStream(InStream, RecordRef, FileName); // Use SetBlobFromStream to set the document blob
            // DocumentAttachment."No." :=
            DocumentAttachment."Document Name" := DocumentName;

            SystemIdFieldNo := RecordRef.SystemIdNo();
            FieldRef := RecordRef.Field(SystemIdFieldNo);
            DocumentAttachment."Record Id" := FieldRef.Value;
            DocumentAttachment."Upload Document Type" := FieldName;
            DocumentAttachment."Table Name" := TableName;
            DocumentAttachment."No." := No;
            DocumentAttachment."DocumentMedia".ImportStream(InStream, FileName);
            DocumentAttachment."Document BLOB".CreateInStream(InStream);
            DocumentAttachment."MIME Type" := MIMEType;
            DocumentAttachment.Modify();

            Clear(FieldRef);

            exit(DocumentAttachment."File Name");
            // FieldRef := RecordRef.Field(FieldNo);
            // FieldRef.Value := DocumentAttachment."File Name";
            // RecordRef.Modify();

        end else
            Message('No document was selected.');
        // exit(0);
    end;

    procedure GetMimeTypeFromFileName(FileName: Text): Text
    var
        FileExtension: Text;
    begin
        // Extract the file extension from the file name
        FileExtension := LowerCase(CopyStr(FileName, StrPos(FileName, '.'), StrLen(FileName) - StrPos(FileName, '.') + 1));

        case FileExtension of
            '.pdf':
                exit('application/pdf');
            '.jpg', '.jpeg':
                exit('image/jpeg');
            '.png':
                exit('image/png');
            '.gif':
                exit('image/gif');
            '.txt':
                exit('text/plain');
            '.doc', '.docx':
                exit('application/msword');
            '.xls', '.xlsx':
                exit('application/vnd.ms-excel');
            '.ppt', '.pptx':
                exit('application/vnd.ms-powerpoint');
            '.zip':
                exit('application/zip');
            '.rar':
                exit('application/x-rar-compressed');
            '.csv':
                exit('text/csv');
            '.json':
                exit('application/json');
            '.xml':
                exit('application/xml');
            '.html', '.htm':
                exit('text/html');
            '.mp4':
                exit('video/mp4');
            '.mp3':
                exit('audio/mpeg');
            '.wav':
                exit('audio/wav');
            '.avi':
                exit('video/x-msvideo');
            '.exe':
                exit('application/x-msdownload');
            else
                exit('application/octet-stream'); // Default MIME type for unknown files
        end;
    end;


    procedure UploadDocumentToBlobStorage(FilePath: Text; FileName: Text; InStream: InStream): Text
    var
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        OutStream: OutStream;
        ResponseMessage: HttpResponseMessage;
        FileManagement: Codeunit "File Management";
        SASUrl: Text;
        TempBlob: Codeunit "Temp Blob";
        FileUrl: Text;
        IsSuccessful: Boolean;
        headers: HttpHeaders;
        responsecontent: Text;
        FileExtension: Text;
        ContentType: Text;

    begin
        // Extract the file extension from the file name
        FileExtension := LowerCase(CopyStr(FileName, StrPos(FileName, '.'), StrLen(FileName) - StrPos(FileName, '.') + 1));


        // Determine the appropriate Content-Type based on the file extension
        case FileExtension of
            '.pdf':
                ContentType := 'application/pdf';
            '.docx':
                ContentType := 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
            '.doc':
                ContentType := 'application/msword';
            '.jpg', '.jpeg':
                ContentType := 'image/jpeg';
            '.png':
                ContentType := 'image/png';
            else
                Error('Unsupported file type: %1. Please upload a valid document format.', FileExtension);
        end;
        // Generate your SAS URL (replace with actual values)
        SASUrl := FilePath;
        // ** Proceed with saving the document **
        TempBlob.CreateOutStream(OutStream);

        CopyStream(OutStream, InStream);

        TempBlob.CreateInStream(InStream);
        // Write the file content to the HTTP content
        HttpContent.WriteFrom(InStream);
        HttpContent.GetHeaders(Headers);
        Headers.Clear(); // Clear existing headers if any
        Headers.Add('x-ms-blob-type', 'BlockBlob');
        // Headers.Add('Content-Type', 'application/octet-stream');
        Headers.Add('Content-Type', ContentType);

        // Send PUT request to Azure Blob Storage
        if HttpClient.Put(SASUrl, HttpContent, ResponseMessage) then begin
            if ResponseMessage.IsSuccessStatusCode() then
                exit(SASUrl)
            else begin
                ResponseMessage.Content().ReadAs(ResponseContent);
                Error('Upload failed. Status Code: %1 - %2. Response Content: %3',
                    ResponseMessage.HttpStatusCode(), ResponseMessage.ReasonPhrase(), ResponseContent);
            end;
        end else
            Error('HTTP request to Azure Blob Storage failed.');
    end;

    procedure GetMIMEType(FileExtension: Text): Text
    begin
        case FileExtension of
            '.pdf':
                exit('application/pdf');
            '.jpg', '.jpeg':
                exit('image/jpeg');
            '.png':
                exit('image/png');
            '.docx':
                exit('application/vnd.openxmlformats-officedocument.wordprocessingml.document');
            else
                exit('application/octet-stream'); // Default MIME type for unknown files
        end;
    end;

    ///
    procedure UploadImageToBlobStorage(FilePath: Text; FileName: Text; InStream: InStream): Text
    var
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders; // Declare HttpHeaders variable
        OutStream: OutStream;
        ResponseMessage: HttpResponseMessage;
        TempBlob: Codeunit "Temp Blob";
        SASUrl: Text;
        ContentType: Text;
        ResponseContent: Text;
        FileExtension: Text;
        FolderName: Text;
    begin
        // Set folder name
        FolderName := 'companylogo';

        // Extract file extension
        FileExtension := LowerCase(CopyStr(FileName, StrPos(FileName, '.'), StrLen(FileName) - StrPos(FileName, '.') + 1));

        // Determine Content-Type
        case FileExtension of
            '.jpg', '.jpeg':
                ContentType := 'image/jpeg';
            '.png':
                ContentType := 'image/png';
            else
                Error('Unsupported image format: %1. Only JPEG or PNG files are allowed.', FileExtension);
        end;

        // Generate the full SAS URL
        SASUrl := StrSubstNo('%1/%2/%3', FilePath, FolderName, FileName);

        // Prepare OutStream and copy from InStream
        TempBlob.CreateOutStream(OutStream);
        CopyStream(OutStream, InStream);

        // Reload the stream and prepare HTTP content
        TempBlob.CreateInStream(InStream);
        HttpContent.WriteFrom(InStream);

        // Retrieve and modify HTTP headers
        HttpContent.GetHeaders(HttpHeaders); // Pass HttpHeaders variable
        HttpHeaders.Clear();
        HttpHeaders.Add('x-ms-blob-type', 'BlockBlob'); // Required header
        HttpHeaders.Add('Content-Type', ContentType);   // Set Content-Type header

        // Send PUT request
        if HttpClient.Put(SASUrl, HttpContent, ResponseMessage) then begin
            if ResponseMessage.IsSuccessStatusCode() then
                exit(SASUrl)
            else begin
                ResponseMessage.Content().ReadAs(ResponseContent);
                Error('Image upload failed. Status Code: %1 - %2. Response: %3',
                    ResponseMessage.HttpStatusCode(), ResponseMessage.ReasonPhrase(), ResponseContent);
            end;
        end else
            Error('HTTP request to upload image to Azure Blob Storage failed.');
    end;

    procedure GetMIMEType1(FileExtension: Text): Text
    begin
        case FileExtension of

            '.jpg', '.jpeg':
                exit('image/jpeg');
            '.png':
                exit('image/png');
            else
                exit('application/octet-stream'); // Default MIME type for unknown files
        end;
    end;
    // procedure UploadImageToBlobStorage(SASUrl: Text; FileName: Text; InStream: InStream): Text
    // var
    //     HttpClient: HttpClient;
    //     HttpContent: HttpContent;
    //     HttpResponse: HttpResponseMessage;
    // begin
    //     // Prepare the HTTP content with the image stream
    //     HttpContent.WriteFrom(InStream);

    //     // Send PUT request to the SAS URL with the image data
    //     if HttpClient.Put(SASUrl, HttpContent, HttpResponse) then
    //         if HttpResponse.IsSuccessStatusCode() then
    //             exit(SASUrl) // Return the URL if upload is successful
    //         else
    //             Error('Upload failed with status code %1', HttpResponse.HttpStatusCode())
    //     else
    //         Error('Failed to send HTTP request.');
    // end;



}


