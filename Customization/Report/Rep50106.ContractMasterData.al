namespace PropertyManagement.PropertyManagement;
using System.Utilities;

report 50106 ContractMasterData
{
    ApplicationArea = All;
    Caption = 'ContractMasterData';
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = 'Contract MasterData.xlsx';
    DefaultLayout = Excel;


    dataset
    {
        dataitem(TenancyContract; "Tenancy Contract")
        {
            column(CustomDateRange; CustomDateRangeText)
            {
            }
            column(Contract_ID; "Contract ID")
            {
            }
            column(Owner_s_Name; "Owner's Name")
            {
            }
            column(Customer_Name; "Customer Name")
            {
            }
            column(Contract_Start_Date; "Contract Start Date")
            {
            }
            column(Contract_End_Date; "Contract End Date")
            {
            }
            column(Contract_Type; "Contract Type")
            {
            }
            column(Proposal_Info; ProposalInfoText)
            {
            }
            column(Contract_Tenor; "Contract Tenor")
            {
            }
            column(Tenant_Contract_Status; "Tenant Contract Status")
            {
            }
            column(Contract_Amount; "Rent Amount")
            {
            }
            column(Annual_Rent_Amount; "Annual Rent Amount")
            {
            }
            column(Security_Deposit_Amount; "Security Deposit Amount")
            {
            }
            column(Property_Name; "Property Name")
            {
            }
            column(Unit_Name; "Unit Name")
            {
            }
            column(UnitID; UnitID)
            {
            }
            column(Unit_Number; "Unit Number")
            {
            }
            column(UnitArea_Sq_Feet; "Unit Sq. Feet")
            {
            }
            column(Unit_Usage_Type; "Usage Type")
            {
            }
            column(Suspension_Date; SuspensionStartDate)
            {
            }
            column(Suspended_Reason_list; "Suspended Reason list")
            {
            }


            column(Grace_Start_Date; "Grace Start Date")
            {
            }
            column(Grace_End_Date; "Grace End Date")
            {
            }
            column(Grace_Period; "Grace Period")
            {
            }

            trigger OnAfterGetRecord()
            var
                StartDateIsInRange: Boolean;
                EndDateIsInRange: Boolean;
                SuspensionReasonRec: Record SuspendReasonTable;
            begin
                // Set the custom date range text
                CustomDateRangeText :=
                    Format(CustomStartDate, 0, '<Day,2>/<Month,2>/<Year,4>') + ' - ' +
                    Format(CustomEndDate, 0, '<Day,2>/<Month,2>/<Year,4>');

                // Check if Contract Start Date or Contract End Date is in the specified range
                StartDateIsInRange := ("Contract Start Date" >= CustomStartDate) and ("Contract Start Date" <= CustomEndDate);
                EndDateIsInRange := ("Contract End Date" >= CustomStartDate) and ("Contract End Date" <= CustomEndDate);

                if not (StartDateIsInRange or EndDateIsInRange) then
                    CurrReport.SKIP(); // Skip record if neither date is in range

                // Reset suspension start date before searching
                SuspensionStartDate := 0D;

                // Find suspension date for the current contract
                SuspensionReasonRec.Reset();
                SuspensionReasonRec.SetRange("Contract ID", "Contract ID");
                if SuspensionReasonRec.FindFirst() then begin
                    SuspensionStartDate := SuspensionReasonRec.DateEffective;
                end;

                // Combine Proposal ID and Renewal Proposal ID after converting them to Text
                ProposalInfoText := 'Proposal ID: ' + Format("Proposal ID") + ' / ' + 'ContractRenewal ID: ' + Format("Renewal Proposal ID");

            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(DateFilter)
                {
                    field(CustomStartDate; CustomStartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Custom Start Date';
                    }
                    field(CustomEndDate; CustomEndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Custom End Date';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }

    }
    var
        CustomStartDate: Date;
        CustomEndDate: Date;
        CustomDateRangeText: Text;
        ProposalInfoText: Text;
        SuspensionStartDate: Date;
}
