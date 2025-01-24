namespace PropertyManagement.PropertyManagement;
using Microsoft.Foundation.Company;

using Microsoft.Sales.Document;
using System.Text;

report 50104 InvoiceTemplate
{
    ApplicationArea = All;
    Caption = 'InvoiceTemplate';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = "InvoiceTemplate.docx";
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPostcode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(No_; "No.")
            {
            }
            column(Posting_Date; Format("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(Bill_to_Address; "Bill-to Address")
            {
            }
            column(Sell_to_Phone_No_; "Sell-to Phone No.")
            {
            }
            column(Sell_to_E_Mail; "Sell-to E-Mail")
            {
            }
            column(VAT_Registration_No_; "VAT Registration No.")
            {
            }
            column(Contract_ID; "Contract ID")
            {
            }
            // column(Property_Name; "Property Name")
            // {
            // }
            // column(Unit_Name; "Unit Name")
            // {
            // }
            // column(Contract_Tenure; "Contract Tenure")
            // {
            // }
            column(BankAccountName; CompanyInfo."Bank Name")
            {
            }
            column(BankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(BankIBAN; CompanyInfo.IBAN)
            {
            }
            column(BankSwiftCode; CompanyInfo."SWIFT Code")
            {
            }
            column(BankBranch; CompanyInfo."Bank Branch No.")
            {
            }
            dataitem("Tenancy Contract"; "Tenancy Contract")
            {
                DataItemLink = "Contract ID" = field("Contract ID");
                column(Property_Name; "Property Name")
                {
                }
                column(Unit_Name; "Unit Name")
                {
                }
                column(Contract_Tenor; "Contract Tenor")
                {
                }
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(SaleLineNo_; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    LineAmountText := Format("Line Amount");
                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalDue += "Amount Including VAT";
                    TotalSubTotal += "Amount Including VAT";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                end;
            }
            dataitem(Totals; System.Utilities.Integer)
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(TotalSubTotal; Format(TotalSubTotal, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, SalesHeader."Currency Code")))
                { }
                column(TotalInvDiscAmount; Format(TotalInvDiscAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, SalesHeader."Currency Code")))
                { }
                column(TotalAmountVAT; Format(TotalAmountVAT, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, SalesHeader."Currency Code")))
                { }
                column(TotalAmountInclVAT; Format(TotalAmountInclVAT, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, SalesHeader."Currency Code")))
                { }
                column("TotalDue"; Format(TotalDue, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, SalesHeader."Currency Code")))
                { }
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
        layout("InvoiceTemplate.docx")
        {
            Type = Word;
            LayoutFile = './InvoiceTemplate.docx';
            Caption = 'InvoiceTemplate (Word)';
            Summary = 'The InvoiceTemplate (Word) provides a simple layout that is also relatively easy for an end-user to modify.';
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
        AutoFormat: Codeunit "Auto Format";
        LineAmountText: Text;
        TransHeaderAmount: Decimal;
        PrevLineAmount: Decimal;
        TotalDue: Decimal;
        TotalSubTotal: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountVAT: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
    // SalesLine: Record "Sales Line";
}
