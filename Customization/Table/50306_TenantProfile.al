// table 50306 "TenantProfile"
// {
//     DataClassification = ToBeClassified;
//     DataCaptionFields = "Tenant ID";

//     fields
//     {
//         field(50100; "Tenant ID"; code[20])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Tenant ID';
//             // AutoIncrement = true;
//             Editable = false;
//             // Optional: Set as Primary Key

//         }
//         field(50101; "Full Name"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Full Name';
//         }

//         field(50102; "Date Of Birth"; Date)
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Date Of Birth';
//         }

//         field(50103; "Nationality"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Nationality';
//         }
//         field(50104; "Emirates ID"; Code[15])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Emirates ID Number';
//         }

//         field(50105; "Emirates ID Expiry Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Emirates ID Expiry Date';
//         }

//         field(50106; "Code Area"; Enum "UAE Phone Code Area") // Using the enum here
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Code Area';
//         }


//         field(50107; "Contact Number"; Text[20])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Contact Number';
//         }
//         field(50108; "Email Address"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Email Address';
//         }
//         field(50109; "Mailing Address"; Text[250])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Mailing Address';
//         }
//         field(50110; "Local Address"; Text[250])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Local Address';
//         }

//         field(50111; "Emergency Contact"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Emergency Contact';
//         }
//         field(50112; "Occupation"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Occupation';
//         }

//         // field(50113; "Property ID"; Code[20])
//         // {
//         //     DataClassification = ToBeClassified;
//         //     Caption = 'Property ID';
//         //     TableRelation = "Property Registration"."Property ID"; // Relation to Property Registration
//         // }
//         // field(50114; "Unit ID"; Code[100])
//         // {
//         //     DataClassification = ToBeClassified;
//         //     Caption = 'Unit ID';
//         //     // TableRelation = "Item".UnitID; // Relation to Item Extension
//         //     TableRelation = "Item"."No."
//         //         where("Property ID" = field("Property ID")); // Dynamically filter Unit IDs based on Property ID

//         // }

//         // Screening fields as checkboxes
//         field(50115; "Application Submission Doc"; Text[250])
//         {
//             Caption = 'Application Submission Doc';
//             DataClassification = ToBeClassified;
//         }
//         field(50116; "Application Submission"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50117; "Identity Verification Document"; Text[250])
//         {
//             Caption = 'Identity Verification Document';
//             DataClassification = ToBeClassified;
//         }
//         field(50118; "Identity Verification"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50119; "Credit Check Document"; Text[250])
//         {
//             Caption = 'Credit Check Document';
//             DataClassification = ToBeClassified;
//         }
//         field(50120; "Credit Check"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50121; "References Check Document"; Text[250])
//         {
//             Caption = 'References Check Document';
//             DataClassification = ToBeClassified;
//         }
//         field(50122; "References Check"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50123; "Background Check Document"; Text[250])
//         {
//             Caption = 'Background Check Document';
//             DataClassification = ToBeClassified;
//         }
//         field(50124; "Background Check"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Background Check';

//         }
//         field(50125; "Employment and Income Document"; Text[250])
//         {
//             Caption = 'Employment and Income Document';
//             DataClassification = ToBeClassified;
//         }
//         field(50126; "Employment&Income Verification"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50127; "Employment Contracts Document"; Text[250])
//         {
//             Caption = 'Employment Contracts Document';
//             DataClassification = ToBeClassified;
//         }
//         field(50128; "Employment Contracts"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }


//         field(50129; "Approve"; Boolean)
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 if "Approve" = true then
//                     "Decline" := false; // Automatically turn off Decline when Approve is selected
//             end;
//         }
//         field(50130; "Decline"; Boolean)
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 if "Decline" = true then
//                     "Approve" := false; // Automatically turn off Decline when Approve is selected
//             end;
//         }

//         field(50131; "ID copies"; Text[250])
//         {
//             Caption = 'ID copies (passport, driving license)';
//             DataClassification = ToBeClassified;
//         }

//         field(50132; "Document Upload"; Text[250])
//         {
//             Caption = 'Document Upload';
//             DataClassification = ToBeClassified;
//         }

//         // New Passport Details fields
//         field(50133; "Passport Number"; Text[20])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Passport Number';
//         }

//         field(50134; "Passport Issue Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Passport Issue Date';
//         }

//         field(50135; "Passport Expiry Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Passport Expiry Date';
//         }

//         field(50136; "Country of Passport"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Country of Passport';
//         }

//         field(50137; "Username"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Username';
//             // Additional properties can be added here if needed
//         }

//         field(50138; "Password"; Code[30])
//         {
//             DataClassification = ToBeClassified; // Marking as sensitive for security
//             Caption = 'Password';
//             // To ensure password handling is secure, this field should be masked or encrypted if supported.
//         }

//         field(50139; "License No."; Code[20])
//         {

//             DataClassification = ToBeClassified;
//             Caption = 'Tenant Trade License No.';
//         }

//         field(50140; "Licensing Authority"; Text[100])
//         {
//             Caption = 'Licensing Authority';
//             DataClassification = ToBeClassified;
//         }

//         field(50141; "Recurring Sales Line Code"; Code[20])
//         {
//             Caption = 'Recurring Sales Line';
//             TableRelation = "Standard Customer Sales Code";
//         }



//     }

//     keys
//     {
//         key(PrimaryKey; "Tenant ID")
//         {
//             Clustered = false;
//         }
//         key(PK; SystemId)
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//         fieldgroup(DropDown; "Tenant ID", "Full Name", "Contact Number")
//         {

//         }
//     }

//     trigger OnInsert()
//     var
//         NoSeriesMgt: Codeunit "No. Series";


//     begin
//         if "Tenant ID" = '' then begin
//             "Tenant ID" := NoSeriesMgt.GetNextNo('TENANTID', Today(), true);
//         end;

//     end;
// }
