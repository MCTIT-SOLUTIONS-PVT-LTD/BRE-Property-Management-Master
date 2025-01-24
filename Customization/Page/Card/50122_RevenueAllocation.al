page 50122 "Revenue Allocation Card"
{
    PageType = Card;
    SourceTable = "Revenue Allocation Details";
    ApplicationArea = All;
    Caption = 'Revenue Allocation Details';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Revenue Allocation Details';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                    Caption = 'Month';
                }
                field("Financial Year"; Rec."Financial Year")
                {
                    ApplicationArea = All;
                    Caption = 'Financial Year';
                }
            }
            group("Revenue Allocation Report Details")
            {
                Caption = 'Revenue Allocation Report Details';
                part("Revenue Allocation Details"; "Revenue Allocation SubGrid")
                {
                    ApplicationArea = All;
                    SubPageLink = "Line No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(FilterContracts)
            {
                ApplicationArea = All;
                Caption = 'Filter Contracts by Month';
                Image = Filter;
                trigger OnAction()
                var
                    tenancyContractRec: Record "Tenancy Contract"; // Replace with the correct table name
                    subGridRec: Record "Revenue Allocation SubGrid"; // Replace with the subgrid's source table
                    contractStartMonth: Integer;
                    contractEndMonth: Integer;
                begin
                    // Filter tenancy contracts
                    subGridRec.Reset();
                    subGridRec.DeleteAll(false); // Clear the subgrid before applying new filters

                    if tenancyContractRec.FindSet() then begin
                        repeat
                            // Extract month values from Start Date and End Date
                            contractStartMonth := Date2DMY(tenancyContractRec."Contract Start Date", 2);
                            contractEndMonth := Date2DMY(tenancyContractRec."Contract End Date", 2);

                        // Check if the Revenue Allocation Month falls within the contract period
                        // if (Date2DMY(Rec.Month, 2) >= contractStartMonth) and
                        //    (Date2DMY(Rec.Month, 2) <= contractEndMonth) then begin
                        //     subGridRec.Init();
                        //     subGridRec."Line No." := Rec."No."; // Link to the main record
                        //     subGridRec."Posting Month" := Rec.Month; // Set Posting Month
                        //     subGridRec.Insert();
                        // end;
                        until tenancyContractRec.Next() = 0;
                    end;

                    // Refresh the page to reflect filtered subgrid data
                    CurrPage.Update();
                end;
            }

        }
    }
}























// page 50122 "Revenue Allocation Card"
// {
//     PageType = Card;
//     SourceTable = "Revenue Allocation Details";
//     ApplicationArea = All;
//     Caption = 'Revenue Allocation Details';
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             group(Group)
//             {
//                 Caption = 'Revenue Allocation Details';
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'No.';
//                 }
//                 field(Month; Rec.Month)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Month';
//                 }
//                 field("Financial Year"; Rec."Financial Year")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Financial Year';
//                 }
//             }
//             group("Revenue Allocation Report Details")
//             {
//                 Caption = 'Revenue Allocation Report Details';
//                 part("Revenue Allocation Details"; "Revenue Allocation SubGrid")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(FilterSubGrid)
//             {
//                 ApplicationArea = All;
//                 Caption = 'Filter Contracts by Month';
//                 Image = Filter;
//                 trigger OnAction()
//                 var
//                     contractMonth: Text[10];
//                 begin
//                     contractMonth := Format(Rec.Month); // Get the month from the current record
//                     // Call a procedure to apply the filter to the subgrid
//                     ApplySubGridFilter(contractMonth);
//                 end;
//             }
//         }
//     }
//     procedure ApplySubGridFilter(contractMonth: Text[10])
//     var
//         subGridRec: Record "Revenue Allocation SubGrid";
//     begin
//         // Apply a filter to the subgrid's source table record
//         subGridRec.SetRange("Posting Month", Rec.Month);

//         // Force the page to refresh and reflect the filtered subgrid data
//         CurrPage.Update;
//     end;


// }
