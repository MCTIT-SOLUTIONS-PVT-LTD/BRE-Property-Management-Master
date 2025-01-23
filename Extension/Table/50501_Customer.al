// tableextension 50501 Mycustomer extends Customer
// {
//     fields
//     {
//         // Add changes to table fields here
//         field(50500; "Customer Type"; Enum "Customer Type Enum")
//         {
//             Caption = 'Customer Type';
//             DataClassification = ToBeClassified;
//         }
//         field(50501; "Business Unit"; Code[20])
//         {
//             Caption = 'Business Unit';
//         }
//     }

// trigger OnInsert()
// var
//     ModuleSetup: Record "Module Setup";
// begin
//     // Find the active module in the Module Setup table
//     if ModuleSetup.FindSet() then
//         repeat
//             if ModuleSetup."Is Active" then begin
//                 // Assign Customer Type based on the active module
//                 case ModuleSetup."Module Name" of
//                     'Property Management':
//                         begin
//                             "Business Unit" := 'PM';
//                             "Customer Type" := "Customer Type Enum"::Tenant;
//                         end;

//                     'Property Sales':
//                         begin
//                             "Business Unit" := 'PS';
//                             "Customer Type" := "Customer Type Enum"::Buyer;
//                         end;

//                 end;
//             end;
//         until ModuleSetup.Next() = 0;
// end;

//     trigger OnInsert()
//     var
//         BusinessUnit: Record "Business Unit";
//     begin
//         if BusinessUnit.Get('PM') then
//             "Business Unit" := 'PM'; // Assign Property Management
//         if BusinessUnit.Get('PS') then
//             "Business Unit" := 'PS'; // Assign Property Sales
//     end;

//     var
//         myInt: Integer;
// }