namespace PropertyManagement.PropertyManagement;

page 50707 paymentdata
{
    APIGroup = 'payment';
    APIPublisher = 'RealeststeDev';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'paymentdata';
    DelayedInsert = true;
    EntityName = 'paymentData';
    EntitySetName = 'paymentData';
    PageType = API;
    SourceTable = "Payment Mode2";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(chequeNumber; Rec."Cheque Number")
                {
                    Caption = 'Cheque Number';
                }
                field(depositBank; Rec."Deposit Bank")
                {
                    Caption = 'Deposit Bank';
                }
                field(depositStatus; Rec."Deposit Status")
                {
                    Caption = 'Deposit Status';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(paymentMode; Rec."Payment Mode")
                {
                    Caption = 'Payment Mode';
                }
                field(paymentSeries; Rec."Payment Series")
                {
                    Caption = 'Payment Series';
                }
                // field(proposalId; Rec."Proposal Id")
                // {
                //     Caption = 'Proposal Id';
                // }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(tenantId; Rec."Tenant Id")
                {
                    Caption = 'Tenant Id';
                }
                field(vatAmount; Rec."VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field("ContractID"; Rec."Contract ID")
                {
                    Caption = 'Contract id';
                }
                field("PaymentStatus"; Rec."Payment Status")
                {
                    Caption = 'Payment Status';
                }
                field("ChequeStatus"; Rec."Cheque Status")
                {
                    Caption = 'Cheque Status';
                }
                field("Invoice"; Rec."Invoice #")
                {
                    Caption = 'Invoice';
                }
                field("Receipt"; Rec."Receipt #")
                {
                    Caption = 'Receipt';
                }
                field("OldCheque"; Rec."Old Cheque #")
                {
                    Caption = 'Old Cheque';
                }
                field("UploadCheque"; Rec."Upload Cheque")
                {
                    Caption = 'Upload Cheque';
                }
                field("Download"; Rec.Download)
                {
                    Caption = 'Download';
                }
                field(View; Rec.View)
                {
                    Caption = 'View';
                }
                field("ViewRevenueDetails"; Rec."View Revenue Details")
                {
                    Caption = 'View Revenue Details';
                }
                field("ViewDocumentURL"; Rec."View Document URL")
                {
                    Caption = 'View Document URL';
                }
                field("EntryNo"; Rec."Entry No.")
                {
                    Caption = 'Entry No';
                }
            }
        }
    }
}
