page 50109 "Common Property List"
{
    PageType = List;
    SourceTable = "Property Registration";
    ApplicationArea = All;
    Caption = 'Common Property List';
    UsageCategory = Lists;
    ShowFilter = false;
    // CardPageId = 31;
    SourceTableView = where("Property Classification" = const('Common'));

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Property ID"; Rec."Property ID")
                {
                    ApplicationArea = All;
                    Caption = 'Property ID';
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = All;
                    Caption = 'Property Name';
                }
                field("Property Type"; Rec."Property Classification")
                {
                    ApplicationArea = All;
                    Caption = 'Property Type';
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.SetRange("Property Classification", 'Common'); // Filter for only vacant properties
    end;

}
