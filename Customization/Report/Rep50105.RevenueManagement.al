namespace PropertyManagement.PropertyManagement;

report 50105 RevenueManagement
{
    ApplicationArea = All;
    Caption = 'RevenueManagement';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = "RevenueManagement.docx";
    dataset
    {
        dataitem(TenancyContract; "Tenancy Contract")
        {
            column(Contract_ID; "Contract ID")
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
        layout("RevenueManagement.docx")
        {
            Type = Word;
            LayoutFile = './RevenueManagement.docx';
            Caption = 'RevenueManagement (Word)';
            Summary = 'The RevenueManagement (Word) provides a simple layout that is also relatively easy for an end-user to modify.';
        }
    }
}
