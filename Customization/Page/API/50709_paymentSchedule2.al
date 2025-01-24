namespace PropertyManagement.PropertyManagement;

page 50709 paymentSchedule2
{
    APIGroup = 'tenants';
    APIPublisher = 'RealeststeDev';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'paymentSchedule2';
    DelayedInsert = true;
    EntityName = 'paymentSchedules';
    EntitySetName = 'paymentScheduless';
    PageType = API;
    SourceTable = "Payment Schedule2";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

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
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(installmentEndDate; Rec."Installment End Date")
                {
                    Caption = 'Installment End Date';
                }
                field(installmentNo; Rec."Installment No.")
                {
                    Caption = 'Installment No.';
                }
                field(installmentStartDate; Rec."Installment Start Date")
                {
                    Caption = 'Installment Start Date';
                }
                // field(proposalID; Rec."Proposal ID")
                // {
                //     Caption = 'Proposal ID';
                // }
                field(secondaryItemType; Rec."Secondary Item Type")
                {
                    Caption = 'Secondary Item Type';
                }
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
                field(tenantID; Rec."Tenant ID")
                {
                    Caption = 'Tenant ID';
                }
                field(vatAmount; Rec."VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field("ContractID"; Rec."Contract ID")
                {
                    Caption = 'Contract ID';
                }
                // field("TotalAmountIncludingVAT"; Rec."Total Amount Including VAT")
                // {
                //     Caption = 'Total Amount Including Vat';
                // }
            }
        }
    }
}
