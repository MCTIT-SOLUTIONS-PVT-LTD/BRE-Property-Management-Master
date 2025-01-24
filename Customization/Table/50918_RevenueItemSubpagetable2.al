// table 50918 "Revenue Item Subpage2"
// {
//     DataClassification = ToBeClassified;


//     fields
//     {



//         field(50100; "ProposalID"; Integer)
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Proposal ID';
//         }

//         field(50101; "Secondary Item Type"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Secondary Item';
//             //TableRelation = "Secondary Item"."Secondary Item Type";
//             TableRelation = "Secondary Item"."Secondary Item Type" WHERE("Payment System" = const("One Time Payment"));

//             trigger OnValidate()
//             var
//                 SecondaryItemRec: Record "Secondary Item";
//             begin
//                 // Check if a record with the selected Secondary Item Type exists
//                 SecondaryItemRec.SetRange("Secondary Item Type", Rec."Secondary Item Type");
//                 if SecondaryItemRec.FindSet() then begin
//                     // Retrieve the VAT % from the Secondary Item record
//                     "VAT %" := SecondaryItemRec."VAT %";
//                 end else begin
//                     // Clear the VAT % field if no matching record is found
//                     "VAT %" := 0;
//                 end;
//             end;


//         }

//         field(50102; "Amount"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Amount';

//             trigger OnValidate()
//             begin
//                 CalcVATAndTotal();
//             end;



//         }

//         field(50103; "VAT %"; Option)
//         {
//             OptionMembers = "0%","5%";
//             Caption = 'VAT %';
//             Editable = false;

//             trigger OnValidate()
//             begin
//                 CalcVATAndTotal();
//             end;
//         }

//         field(50104; "VAT Amount"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'VAT Amount';
//             Editable = false;

//             trigger OnValidate()
//             begin
//                 "VAT Amount" := Amount * ("VAT %" / 100);
//             end;

//         }

//         field(50105; "Amount Including VAT"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Amount Including VAT';
//             Editable = false;

//             trigger OnValidate()
//             begin
//                 "Amount Including VAT" := Amount + "VAT Amount";
//             end;
//         }

//         field(50106; "Start Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Start Date';
//             Editable = True;
//         }

//         field(50107; "End Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'End Date';
//             Editable = True;
//         }

//         // field(50108; "No. of Installments"; Integer)
//         // {
//         //     DataClassification = ToBeClassified;
//         //     Caption = 'No. of Installments';
//         // }
//         field(50109; "Link"; Text[250])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Link';
//             InitValue = 'Update Data';

//         }
//         field(50110; "Entry No."; Integer)
//         {
//             DataClassification = ToBeClassified;
//             AutoIncrement = true;
//         }
//     }

//     keys
//     {
//         key(Key1; "Entry No.", ProposalID)
//         {
//             Clustered = true;
//         }
//     }


//     // procedure CalculateAmounts()
//     // begin
//     //     "VAT Amount" := Amount * ("VAT %" / 100);
//     //     "Amount Including VAT" := Amount + "VAT Amount";
//     // end;


//     // Method to calculate VAT Amount and Amount Including VAT
//     local procedure CalcVATAndTotal()
//     begin
//         "VAT Amount" := Amount * ("VAT %" / 100);
//         "Amount Including VAT" := Amount + "VAT Amount";
//     end;
// }
