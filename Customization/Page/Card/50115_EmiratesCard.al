page 50115 "Emirate Card"
{
    PageType = Card;
    SourceTable = Emirate;
    ApplicationArea = All;
    Caption = 'Emirate Card';
    // UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Emirate Details';
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false; // The ID is not editable since it's auto-incrementing
                }
                field("Sl No."; Rec."Sl No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sl No.';
                    Editable = false;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country Code';
                    // TableRelation = "Primary Classification";
                    // Add a lookup to the Primary Classification table
                    // Lookup = true;
                }
                field("Emirate Name"; Rec."Emirate Name")
                {
                    ApplicationArea = All;
                    Caption = 'Emirate Name';
                }
            }
        }
    }



    // Adding navigation from the list page
    // usagecategory = Lists;
}
