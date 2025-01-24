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
                Caption = 'Custom Date Range';
            }
            column(Contract_Start_Date; "Contract Start Date")
            {
            }
            column(Contract_End_Date; "Contract End Date")
            {
            }
            column(Contract_ID; "Contract ID")
            {
            }
            column(Contract_Type; "Contract Type")
            {
            }
            column(Proposal_ID; "Proposal ID")
            {
            }
            column(Renewal_Proposal_ID; "Renewal Proposal ID")
            {
            }
            column(Owner_s_Name; "Owner's Name")
            {
            }
            column(Tenant_ID; "Tenant ID")
            {
            }
            column(Customer_Name; "Customer Name")
            {
            }
            column(Email_Address; "Email Address")
            {
            }
            column(Contract_Tenor; "Contract Tenor")
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
            column(Payment_Frequency; "Payment Frequency")
            {
            }
            column(Payment_Method; "Payment Method")
            {
            }
            column(Security_Deposit_Amount; "Security Deposit Amount")
            {
            }
            column(Rent_Amount; "Rent Amount")
            {
            }
            column(Annual_Rent_Amount; "Annual Rent Amount")
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
            column(Tenant_Contract_Status; "Tenant Contract Status")
            {
            }
            column(Renewal_Contract_Status; "Renewal Contract Status")
            {
            }
            column(Suspended_Reason_list; "Suspended Reason list")
            {
            }
            trigger OnAfterGetRecord()
            var
                StartDateIsInRange: Boolean;
                EndDateIsInRange: Boolean;
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
}
