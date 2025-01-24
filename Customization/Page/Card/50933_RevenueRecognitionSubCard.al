page 50933 "Revenue Recognition Card2"
{
    PageType = ListPart;
    SourceTable = "Revenue Recognition Subpage";
    ApplicationArea = All;
    Caption = 'Revenue Recognition Card2';
    // UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {


                field("Month"; Rec."Month")
                {
                    ApplicationArea = All;
                    // Editable = false; // The ID is not editable since it's auto-incrementing
                    // Lookup = true;
                }

                field("No. of Days"; Rec."No. of Days")
                {
                    ApplicationArea = All;
                    // Editable = false; // The ID is not editable since it's auto-incrementing
                    // Lookup = true;
                }

                field("RR - Method 1 (Day)"; Rec."RR - Method 1 (Day)")
                {
                    ApplicationArea = All;
                    // Editable = false; // The ID is not editable since it's auto-incrementing
                    // Lookup = true;
                }


                field("RR - Method 2 (Month)"; Rec."RR - Method 2 (Month)")
                {
                    ApplicationArea = All;
                    // Editable = false; // The ID is not editable since it's auto-incrementing
                    // Lookup = true;
                }



            }

            group(TotalAmountCalculation)
            {
                field("Total Amount(Day)"; Rec."Total Amount(Day)")
                {
                    Caption = 'Total Amount(Day)';
                }
                field("Total Amount(Month)"; Rec."Total Amount(Month)")
                {
                    Caption = 'Total Amount(Month)';
                }

            }


        }
    }








}



