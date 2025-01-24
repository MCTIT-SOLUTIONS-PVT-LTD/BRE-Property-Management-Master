codeunit 50501 "Azure Blob Management"
{

    procedure UploadToAzureBlobDirectly(var InStream: InStream; FileName: Text; BlobUrl: Text): Text
    var
        HttpClient: HttpClient;
        TokenClient: HttpClient;
        Response: HttpResponseMessage;
        TokenResponse: HttpResponseMessage;
        Content: HttpContent;
        Headers: HttpHeaders;
        TokenContent: Text;
        TokenJson: Text;
        AccessToken: Text;
        ClientId: Text;
        ClientSecret: Text;
        TenantId: Text;
        AuthUrl: Text;
        TokenHttpContent: HttpContent;
        TokenHeaders: HttpHeaders;
        ResponseContent: Text;
        JsonObject: JsonObject;
        Token: JsonToken;
    begin
        // Ensure ClientId, ClientSecret, and TenantId are configured securely
        ClientId := 'c011b4ac-350c-401e-a7b1-93d04b79ee11'; // Replace with your actual ClientId
        ClientSecret := 'vGl8Q~l.oAxrZRZH6WXkWdIZ2cv5Mc2ZNYvbecal'; // Ensure secure storage
        TenantId := '0fc6d7a4-aa1d-4825-bc34-7dd0c18a4f63'; // Replace with your actual TenantId
        AuthUrl := StrSubstNo('https://login.microsoftonline.com/%1/oauth2/v2.0/token', TenantId);

        // Prepare request body for obtaining the token
        TokenJson := 'grant_type=client_credentials' +
                     '&client_id=' + ClientId +
                     '&client_secret=' + ClientSecret +
                     '&scope=https://storage.azure.com/.default';

        // Create HttpContent from the TokenJson text
        TokenHttpContent.WriteFrom(TokenJson);
        TokenHttpContent.GetHeaders(TokenHeaders);
        if not TokenHeaders.Contains('Content-Type') then
            TokenHeaders.Add('Content-Type', 'application/x-www-form-urlencoded');

        // Send request to get the access token
        if not TokenClient.Post(AuthUrl, TokenHttpContent, TokenResponse) then begin
            TokenResponse.Content().ReadAs(ResponseContent);
            Error('Failed to obtain access token. Response Content: %1', ResponseContent);
        end;

        TokenResponse.Content().ReadAs(TokenContent);

        // Parse the token response
        if not JsonObject.ReadFrom(TokenContent) or not JsonObject.Get('access_token', Token) then
            Error('Failed to extract access token from response. Response Content: %1', TokenContent);

        AccessToken := Token.AsValue().AsText();

        // Set up HttpContent from the input stream (file to upload)
        Content.WriteFrom(InStream);
        Content.GetHeaders(Headers);

        // Add required headers for uploading to Azure Blob Storage
        Headers.Add('Authorization', 'Bearer ' + AccessToken);
        Headers.Add('x-ms-blob-type', 'BlockBlob');
        if not Headers.Contains('Content-Type') then
            Headers.Add('Content-Type', 'application/octet-stream');

        // Perform the PUT request to upload the blob
        if HttpClient.Put(BlobUrl + '/' + FileName, Content, Response) then begin
            if Response.IsSuccessStatusCode() then
                exit('Upload successful. Blob URL: ' + BlobUrl + '/' + FileName)
            else begin
                Response.Content().ReadAs(ResponseContent);
                Error('Failed to upload to Azure Blob Storage. Status Code: %1 - %2. Response Content: %3',
                      Response.HttpStatusCode(), Response.ReasonPhrase(), ResponseContent);
            end;
        end else
            Error('HTTP request to upload blob failed.');
    end;

    procedure GetTokenFromResponse(ResponseContent: Text): Text
    var
        JsonObject: JsonObject;
        Token: JsonToken;
        JsonValue: JsonValue;
        AccessToken: Text;
    begin
        if JsonObject.ReadFrom(ResponseContent) then
            if JsonObject.SelectToken('access_token', Token) then begin
                // Convert JsonToken to JsonValue
                JsonValue := Token.AsValue();

                // Use AsText() to extract the value as text
                AccessToken := JsonValue.AsText();
                exit(AccessToken);
            end;
        Error('Failed to retrieve access token from response.');
    end;





}