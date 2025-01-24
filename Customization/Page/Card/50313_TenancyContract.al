page 50313 "Tenancy Contract Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Tenancy Contract";
    Caption = 'Tenancy Contract';

    layout
    {
        area(content)
        {
            // Group for General Information
            group("General Info")
            {
                Caption = 'General Information';


                field("Contract ID"; rec."Contract ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Contract Type"; rec."Contract Type")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateFieldsEnable();
                    end;
                }
                field("Proposal ID"; Rec."Proposal ID")
                {
                    ApplicationArea = All;
                    Enabled = ProposalIDEnabled;
                }

                field("Renewal Proposal ID"; rec."Renewal Proposal ID")
                {
                    ApplicationArea = All;
                    Enabled = RenewalProposalIDEnabled;
                }
                field("Contract Date"; Rec."Contract Date")
                {
                    ApplicationArea = All;
                }
            }

            group("Owner / Lessor Information")
            {
                field("Owner's Name"; rec."Owner's Name")
                {
                    ApplicationArea = All;
                }

                field("Lessor's Name"; rec."Lessor's Name")
                {
                    ApplicationArea = All;
                }

                field("Lessor's Emirates ID"; rec."Lessor's Emirates ID")
                {
                    ApplicationArea = All;
                }

                field("License No."; rec."License No.")
                {
                    ApplicationArea = All;
                }

                field("Licensing Authority"; rec."Licensing Authority")
                {
                    ApplicationArea = All;
                }

                field("Lessor's Email"; rec."Lessor's Email")
                {
                    ApplicationArea = All;
                }

                field("Lessor's Phone"; rec."Lessor's Phone")
                {
                    ApplicationArea = All;
                }
            }

            // Group for Tenant and Customer Information
            group("Tenant & Customer Info")
            {
                Caption = 'Tenant & Customer Information';
                field("Tenant ID"; rec."Tenant ID")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    Editable = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    Editable = false;
                }
                field("Emirates ID"; rec."Emirates ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Contact Number"; rec."Contact Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Email Address"; rec."Email Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Tenant_License No."; Rec."Tenant_License No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Tenant_Licensing Authority"; Rec."Tenant_Licensing Authority")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
            }

            // Group for Property Information
            group("Property Info")
            {
                Caption = 'Property Information';
                field("Property ID"; rec."Property ID")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    Editable = false;
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Property Classification"; rec."Property Classification")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    Editable = false;
                }
                field("Property Type"; rec."Property Type")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    Editable = false;
                }

                field("Praposal Type Selected"; rec."Praposal Type Selected")
                {
                    ApplicationArea = All;
                    // Lookup = true; // Enable lookup for Property ID
                    Caption = 'Unit Category';
                    Editable = false;

                }
                field("Unit ID"; rec."Unit ID")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    Editable = false;
                }

                field("Merge Unit ID"; Rec."Merge Unit ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Lookup = true; // Enable lookup for Unit ID
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Unit Number"; Rec."Unit Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Unit Address"; rec."Unit Address")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Unit Classification"; rec."Usage Type")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("Unit Type"; rec."Unit Type")
                {
                    ApplicationArea = All;
                    Editable = false;

                }



                field("Uniq Unit ID"; Rec.UnitID) // Auto-generated Unit ID
                {
                    ApplicationArea = All;
                    Caption = 'Uniq Unit ID';
                    Editable = false;
                }

                field("Single Unit Name"; Rec."Single Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }

                field("Market Rate per Sq. Ft."; rec."Market Rate per Sq. Ft.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }


                field("Ejari Name"; Rec."Ejari Name")
                {
                    ApplicationArea = All;
                }
                field("Unit Sq. Feet"; Rec."Unit Sq. Feet")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Property Size"; Rec."Property Size")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Base Unit of Measure"; rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    Lookup = true;
                }

                field("Makani Number"; Rec."Makani Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Emirate; Rec.Emirate)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Community; Rec.Community)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("DEWA Number"; Rec."DEWA Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Facilities/Amenities"; rec."Facilities/Amenities")
                {
                    ApplicationArea = All;
                }
            }

            // Group for Contract Information
            group("Contract Details")
            {
                Caption = 'Contract Details';
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Contract Tenor"; Rec."Contract Tenor")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Rent Amount"; Rec."Rent Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    //Caption = 'Contract Amount';
                }

                field("Annual Rent Amount"; Rec."Annual Rent Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Payment Frequency"; rec."Payment Frequency")
                {
                    ApplicationArea = All;
                    Caption = 'Frequency of payment';
                    Editable = false;
                }
                field("Payment Method"; rec."Payment Method")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Mode';
                    Editable = false;
                }
                field("Security Deposit Amount"; Rec."Security Deposit Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No of Installments"; rec."No of Installments")
                {
                    ApplicationArea = All;
                    Caption = 'No of Installments';
                    // Visible = false;
                }
            }

            // Group for Grace Period Information
            group("Grace Period Info")
            {
                Caption = 'Grace Period Information';

                field("Grace Start Date"; Rec."Grace Start Date")
                {
                    ApplicationArea = All;
                }
                field("Grace End Date"; Rec."Grace End Date")
                {
                    ApplicationArea = All;
                }
                field("Grace Period"; Rec."Grace Period")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Handover is Completed"; rec."Handover is Completed")
                {
                    ApplicationArea = All;
                }

                field("Handover of PDC"; rec."Handover of PDC")
                {
                    ApplicationArea = All;
                }
                field("Signed TC Document"; rec."Signed TC Document")
                {
                    ApplicationArea = All;
                }
                field("Handover Unit"; rec."Handover Unit")
                {
                    ApplicationArea = All;
                }

                field("upload document"; rec."upload document")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        AzureBlobUploader: Codeunit "Azure Blob Management";
                        InStream: InStream;
                        FileName: Text;
                        SASUrlBase: Text;
                        SASUrlWithFileName: Text;
                        UploadResult: Text;
                        TempBlob: Codeunit "Temp Blob";
                        ValidFormats: List of [Text];
                        FileExtension: Text[10];
                        FileSize: Decimal;
                        ConfigRecord: Record AzureConfiguration;

                    begin
                        // Validate and retrieve the SAS URL from the configuration table
                        if not ConfigRecord.FindFirst() then
                            Error('Azure configuration is missing. Please set up the SAS URL in the Azure Configuration table.');

                        ValidFormats.Add('.pdf');
                        ValidFormats.Add('.docx');
                        ValidFormats.Add('.jpg');
                        ValidFormats.Add('.jpeg');
                        // Get the SAS base URL (without the file name)
                        SASUrlBase := ConfigRecord."SAS URL";

                        // Load the file to be uploaded into an InStream
                        if UploadIntoStream('Select a Document', '', '(*.pdf, *.docx,*.jpeg, *.jpg)|*.pdf;*.docx;*.jpeg;*.jpg', FileName, InStream) then begin

                            FileExtension := LowerCase(CopyStr(FileName, StrPos(FileName, '.'), StrLen(FileName) - StrPos(FileName, '.') + 1));
                            if not ValidFormats.Contains(FileExtension) then
                                Error('Unsupported file format. Please upload PDF, DOCX, JPEG or JPG.');

                            FileSize := InStream.Length / 1024 / 1024; // Convert to MB
                            if FileSize > 5 then
                                Error('File is too large. Maximum size allowed is 5MB.');
                            // Append the file name to the base SAS URL to create a full SAS URL
                            SASUrlWithFileName := StrSubstNo('%1/%2?%3', CopyStr(SASUrlBase, 1, StrPos(SASUrlBase, '?') - 1), FileName, CopyStr(SASUrlBase, StrPos(SASUrlBase, '?') + 1));


                            // Call the upload function with the modified SAS URL
                            UploadResult := documentattachment.UploadDocumentToBlobStorage(SASUrlWithFileName, FileName, InStream);
                            // Message('Upload Result: %1', UploadResult);

                            // Optionally, store metadata about the uploaded document in the table
                            Rec."Upload Document" := FileName;
                            Rec."view Document" := UploadResult;
                            // Rec."View Document URL" := UploadResult;
                            Rec.Modify();
                            Message('Document uploaded successfully: %1', FileName);
                        end else
                            Message('No document was selected` for upload.');
                    end;
                }

                field("view Document"; Rec."view Document")
                {
                    ApplicationArea = All;
                    Editable = true;
                    DrillDown = true;
                    Visible = false;
                    trigger OnDrillDown()
                    var
                        FileURL: Text;
                    begin
                        // Get the URL of the uploaded document
                        FileURL := Rec."view Document";

                        // Check if the file URL is not empty
                        if FileURL = '' then
                            Error('No document is available to view.');

                        // Open the file URL in the browser (new tab)
                        OpenFileInBrowser(FileURL);
                    end;
                }
                field("Update Contract Status"; Rec."Update Contract Status")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        // Check if "Update Contract Status" has a value other than its default (e.g., <Blank>)
                        if Rec."Update Contract Status" <> Rec."Update Contract Status"::" " then
                            Rec."Yes/No" := true
                        else
                            Rec."Yes/No" := false;
                    end;
                }

                field("Yes/No"; rec."Yes/No")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Tenant Contract Status"; rec."Tenant Contract Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Renewal Contract Status"; rec."Renewal Contract Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }


                field("Created By"; rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Suspended Reason list"; Rec."Suspended Reason list")
                {
                    ApplicationArea = All;
                    ToolTip = 'Click to open the Suspended Reason List.';
                    Style = Strong; // Makes the field look like a hyperlink
                    StyleExpr = true;

                    trigger OnAssistEdit()
                    var
                        SuspendedReasonRec: Record "SuspendReasonTable";
                    begin
                        // Filter the Suspended Reason List page by the current Contract ID
                        SuspendedReasonRec.SetRange("Contract ID", Rec."Contract ID");
                        Page.Run(Page::"SuspendReasonList", SuspendedReasonRec);
                    end;
                }


            }









            group("Lease Unit Details")
            {
                Caption = 'Unit Details';
                part("Unit all Details"; "Sub Lease Merged Units Card")
                {
                    SubPageLink = "Merge Unit ID" = FIELD("Merge Unit ID"); // Link to filter attachments for this owner only
                    ApplicationArea = All;
                    Visible = Rec."Praposal Type Selected" = Rec."Praposal Type Selected"::"Merge Unit"; // Visible when "Praposal Type Selected" is "Merge Unit"
                }
            }

            group("Other Payments")
            {
                part("Revenues"; "Tenancy Contract SubPage Card")
                {
                    SubPageLink = ContractID = FIELD("Contract ID"); // Link to filter attachments for this owner only
                    ApplicationArea = All;
                    // Visible = isVisible;
                }
            }


        }
    }
    actions
    {
        area(Reporting)
        {

            action("Run Report")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    TenancyContract: Record "Tenancy Contract";
                    ReportDubai: Report "Tenancy Contract";
                    ReportAbuDhabi: Report "AbuDhabi_Contract";
                begin
                    TenancyContract.SetRange("Contract ID", Rec."Contract ID");  // Set appropriate filters

                    if Rec.Emirate = 'Dubai' then begin
                        ReportDubai.SetTableView(TenancyContract);
                        ReportDubai.RunModal();
                    end else if Rec.Emirate = 'Abu Dhabi' then begin
                        ReportAbuDhabi.SetTableView(TenancyContract);
                        ReportAbuDhabi.RunModal();
                    end;
                end;
            }



        }
    }
    procedure OpenFileInBrowser(URL: Text)
    begin
        // Use the Hyperlink method to open the file in the browser
        if URL <> '' then
            Hyperlink(URL)
        else
            Error('The file URL is invalid.');
    end;

    var
        unitId: code[20];
        documentattachment: Codeunit UploadAttachment;

    var
        ProposalIDEnabled: Boolean;
        RenewalProposalIDEnabled: Boolean;




    // trigger OnAfterGetRecord()
    // begin
    //     // EnableSingleUnit := true;
    //     // UpdateUnitEnableState();
    //     CurrPage."Revenues".Page.SetContractID(Rec."Contract ID");
    //     // CurrPage."Revenue".Page.SetStartEndDate(Rec."Lease Start Date", Rec."Lease End Date");
    //     CurrPage."Revenues".Page.SetTenantID(Rec."Tenant ID");

    // end;

    trigger OnAfterGetRecord()
    begin

        CurrPage."Revenues".Page.SetContractID(Rec."Contract ID");
        // CurrPage."Revenue".Page.SetStartEndDate(Rec."Lease Start Date", Rec."Lease End Date");
        CurrPage."Revenues".Page.SetTenantID(Rec."Tenant ID");
        CurrPage."Revenues".Page.SetProposalId(Rec."Proposal ID");

        UpdateFieldsEnable();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CurrPage."Revenues".Page.SetContractID(Rec."Contract ID");
        // CurrPage."Revenue".Page.SetStartEndDate(Rec."Lease Start Date", Rec."Lease End Date");
        CurrPage."Revenues".Page.SetTenantID(Rec."Tenant ID");
        CurrPage."Revenues".Page.SetProposalId(Rec."Proposal ID");




    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage."Revenues".Page.SetContractID(Rec."Contract ID");
        //CurrPage."Revenue".Page.SetStartEndDate(Rec."Lease Start Date", Rec."Lease End Date");
        CurrPage."Revenues".Page.SetTenantID(Rec."Tenant ID");
        CurrPage."Revenues".Page.SetProposalId(Rec."Proposal ID");


    end;



    local procedure UpdateFieldsEnable()
    begin
        ProposalIDEnabled := Rec."Contract Type" = Rec."Contract Type"::"New Contract";
        RenewalProposalIDEnabled := Rec."Contract Type" = Rec."Contract Type"::"Renewal Contract";

        CurrPage.Update(false);
    end;


}
