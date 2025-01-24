page 50110 "Property Type Card"
{
    PageType = Card;
    SourceTable = "Property Type";
    ApplicationArea = All;
    Caption = 'Property Type Card';
    // UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Property Type Details';
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false; // The ID is not editable since it's auto-incrementing
                }
                field("Classification Name"; Rec."Classification Name")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification';
                    ToolTip = 'Select the associated primary classification.';
                    // TableRelation = "Primary Classification";
                    // Add a lookup to the Primary Classification table
                    // Lookup = true;
                }
                field("Property Type"; Rec."Property Type")
                {
                    ApplicationArea = All;
                    Caption = 'Property Type';
                    ToolTip = 'Enter the property type.';
                }
            }
        }
    }



    // Adding navigation from the list page
    // usagecategory = Lists;
}
