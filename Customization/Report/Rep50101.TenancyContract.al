namespace PropertyManagement.PropertyManagement;
using Microsoft.Foundation.Company;

report 50101 "Tenancy Contract"
{
    ApplicationArea = All;
    Caption = 'Tenancy Contract';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = "TenancyContract.docx";
    dataset
    {
        dataitem(TenancyContract; "Tenancy Contract")
        {
            column(OwnersName; "Owner's Name")
            {
            }
            column(LessorsName; "Lessor's Name")
            {
            }
            column(LessorsEmiratesID; "Lessor's Emirates ID")
            {
            }
            column(LicenseNo; "License No.")
            {
            }
            column(LicensingAuthority; "Licensing Authority")
            {
            }
            column(LessorsEmail; "Lessor's Email")
            {
            }
            column(LessorsPhone; "Lessor's Phone")
            {
            }
            column(EmiratesID; "Emirates ID")
            {
            }
            column(EmailAddress; "Email Address")
            {
            }
            column(TenantID; "Tenant ID")
            {
            }
            column(PropertyClassification; "Property Classification")
            {
            }
            column(PropertyName; "Property Name")
            {
            }
            column(PropertyType; "Property Type")
            {
            }
            column(PropertyID; "Property ID")
            {
            }
            column(CustomerName; "Customer Name")
            {
            }
            column(AnnualRentAmount; "Annual Rent Amount")
            {
            }
            column(ContractTenor; "Contract Tenor")
            {
            }
            column(Contact_Number; "Contact Number")
            {
            }
            column(Customer_Name; "Customer Name")
            {
            }
            column(Contract_Tenor; "Contract Tenor")
            {
            }
            column(Rent_Amount; "Rent Amount")
            {
            }
            column(Annual_Rent_Amount; "Annual Rent Amount")
            {
            }
            column(Payment_Frequency; "Payment Frequency")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(Tenant_License_No_; "Tenant_License No.")
            {
            }
            column(Tenant_Licensing_Authority; "Tenant_Licensing Authority")
            {
            }
            column(Unit_Number; "Unit Number")
            {
            }
            column(Makani_Number; "Makani Number")
            {
            }
            column(DEWA_Number; "DEWA Number")
            {
            }
            column(Emirate; Emirate)
            {
            }
            column(Community; Community)
            {
            }
            column(Security_Deposit_Amount; "Security Deposit Amount")
            {
            }
            column(Property_Size; "Property Size")
            {
            }
            column(Base_Unit_of_Measure; "Base Unit of Measure")
            {
            }
            column(Payment_Method; "Payment Method")
            {
            }
            column(Contract_Start_Date; Format("Contract Start Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }

            column(Contract_End_Date; Format("Contract End Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }

            column(No_of_Installments; "No of Installments")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
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
    rendering
    {
        layout("TenancyContract.docx")
        {
            Type = Word;
            LayoutFile = './TenancyContract.docx';
            Caption = 'TenancyContract (Word)';
            Summary = 'The TenancyContract (Word) provides a simple layout that is also relatively easy for an end-user to modify.';
        }

    }
    trigger OnInitReport()
    begin
        if not CompanyInfo.Get() then begin
            Error('Company Information not found.');
        end else begin
            // CompanyAddress := CompanyInfo.City + ', ' + CompanyInfo.County + ' ' + CompanyInfo."Post Code";
            CompanyInfo.CalcFields(Picture);
        end;
    end;

    var
        CompanyInfo: Record "Company Information";
}
