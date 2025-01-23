// pageextension 50503 CustomerCard extends "Customer Card"
// {
//     layout
//     {
//         modify("No.")
//         {
//             Editable = false;

//         }
//         // Add changes to page layout here
//         addlast(General)
//         {
//             field("Customer Type"; Rec."Customer Type")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Customer Type';
//             }

//             field("Business Unit"; Rec."Business Unit")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Business unit';
//             }
//         }
//     }

//     actions
//     {
//         // Add changes to page actions here
//     }

//     var
//         myInt: Integer;
// }