page 50710 "Approval Payment Request"
{
    PageType = List;
    SourceTable = "Approval Payment Request";
    ApplicationArea = All;
    Caption = 'Payment Change Request Status List';
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Tenant ID"; Rec."Tenant ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Proposal ID"; Rec."Proposal ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                    Editable = false;


                }
                // field("Changed Payment Series"; Rec."Changed Payment Series")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                field("Payment Series"; Rec."Payment Series")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Change Amount"; Rec."Change Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Payment mode"; Rec."Payment mode")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vat Amount"; Rec."Vat Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Deposit Bank"; Rec."Deposit Bank")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;

                trigger OnAction()
                var
                    SelectedRecs: Record "Approval Payment Request";
                    ApproveCount: Integer;
                    ErrorCount: Integer;
                begin
                    CurrPage.SetSelectionFilter(SelectedRecs);

                    if SelectedRecs.IsEmpty() then begin
                        Message('No records selected for approval.');
                        exit;
                    end;

                    ApproveCount := 0;
                    ErrorCount := 0;

                    if SelectedRecs.FindSet() then
                        repeat
                            if SelectedRecs.Status = 'Pending' then begin
                                SelectedRecs.Status := 'Approve';
                                SelectedRecs.Modify();
                                ApproveCount += 1;
                            end else
                                ErrorCount += 1;
                        until SelectedRecs.Next() = 0;

                    Commit();
                    CurrPage.Update(false);

                    Message('%1 record(s) approved. %2 record(s) were not in "Pending" status.', ApproveCount, ErrorCount);

                    //  ProcessCombineRequest2();

                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Image = Reject;

                trigger OnAction()
                var
                    SelectedRecs: Record "Approval Payment Request";
                    RejectCount: Integer;
                    ErrorCount: Integer;
                begin
                    // Store selected records
                    CurrPage.SetSelectionFilter(SelectedRecs);

                    if SelectedRecs.IsEmpty() then begin
                        Message('No records selected for rejection.');
                        exit;
                    end;

                    RejectCount := 0;
                    ErrorCount := 0;

                    if SelectedRecs.FindSet() then
                        repeat
                            if SelectedRecs.Status = 'Pending' then begin
                                SelectedRecs.Status := 'Reject'; // Set status to "Declined"
                                SelectedRecs.Modify();
                                RejectCount += 1;
                            end else
                                ErrorCount += 1; // Count records that are not in "Pending" status
                        until SelectedRecs.Next() = 0;

                    Commit(); // Commit changes
                    CurrPage.Update(false); // Refresh page

                    // Display result messages
                    Message('%1 record(s) rejected. %2 record(s) were not in "Pending" status.', RejectCount, ErrorCount);
                end;
            }
        }

        area(navigation)
        {

        }
    }



    // procedure ProcessCombineRequest()
    // var
    //     PaymentChangeReqTable: Record "Approval Payment Request"; // Replace with your actual table name
    //     PaymentModeTable: Record "Payment Mode2"; // Replace with your actual table name
    //     payseries: Text[100];
    // begin

    //     // Debug: Log current record IDs
    //     Message('Processing Record for: Contract ID: %1, Tenant ID: %2',
    //         Rec."Contract ID", Rec."Tenant ID");

    //     // Filter PaymentChangeReqTable based on the current record's IDs
    //     PaymentChangeReqTable.Reset();
    //     PaymentChangeReqTable.SetRange("Contract ID", Rec."Contract ID");
    //     PaymentChangeReqTable.SetRange("Tenant ID", Rec."Tenant ID");
    //     PaymentChangeReqTable.SetRange("ID", Rec."ID");
    //     PaymentChangeReqTable.SetRange(Status, 'Approve');
    //     PaymentChangeReqTable.SetRange("Request Type", 'Combine');

    //     // Debug: Check if filtered records exist
    //     if not PaymentChangeReqTable.FindSet() then begin
    //         Message('No matching records found for Contract ID: %1, Tenant ID: %2, ID: %3',
    //             Rec."Contract ID", Rec."Tenant ID", Rec."ID");
    //         exit;
    //     end
    //     else begin

    //         // Process the filtered records
    //         repeat
    //             // Debug: Log each record being processed
    //             Message('Processing Record: Contract ID: %1, Tenant ID: %2, ID: %3',
    //                 PaymentChangeReqTable."Contract ID",
    //                 PaymentChangeReqTable."Tenant ID", Rec."ID");

    //             // Fetch the last payment series if any
    //             PaymentModeTable.Reset(); // Reset to clear filters
    //             if PaymentModeTable.FindLast() then
    //                 payseries := PaymentModeTable."Payment Series";

    //             Clear(PaymentModeTable);

    //             // Insert new record in Payment Mode table
    //             PaymentModeTable.Init();
    //             PaymentModeTable."Contract ID" := PaymentChangeReqTable."Contract ID";
    //             PaymentModeTable."Tenant ID" := PaymentChangeReqTable."Tenant ID";
    //             PaymentModeTable."ID" := PaymentChangeReqTable."ID";
    //             //PaymentModeTable."Payment Series" := PaymentChangeReqTable."Changed Payment Series"; // Example field
    //             PaymentModeTable."Amount Including VAT" := PaymentChangeReqTable."Change Amount";
    //             PaymentModeTable.Amount := PaymentChangeReqTable.Amount;
    //             PaymentModeTable."VAT Amount" := PaymentChangeReqTable."Vat Amount";
    //             PaymentModeTable."Due Date" := PaymentChangeReqTable."Due Date";
    //             PaymentModeTable.Insert(true);
    //             Clear(PaymentModeTable);
    //         until PaymentChangeReqTable.Next() = 0;
    //     end;

    //     Message('Processing complete.');
    // end;












    procedure ProcessCombineRequest2()
    var
        PaymentChangeReqTable: Record "Approval Payment Request"; // Replace with your actual table name
        PaymentModeTable: Record "Payment Mode2"; // Replace with your actual table name
        payseries: Text[20];
        NewPaymentCode: Code[20];
        SequenceNo: Integer;
        Combineseries: Text[100];


    begin
        // Debug: Log current record IDs
        Message('Processing Record for: Contract ID: %1, Tenant ID: %2, ID: %3',
            Rec."Contract ID", Rec."Tenant ID", Rec."ID");

        // Filter PaymentChangeReqTable based on the current record's IDs
        PaymentChangeReqTable.Reset();
        PaymentChangeReqTable.SetRange("Contract ID", Rec."Contract ID");
        PaymentChangeReqTable.SetRange("Tenant ID", Rec."Tenant ID");
        PaymentChangeReqTable.SetRange("ID", Rec."ID");
        PaymentChangeReqTable.SetRange(Status, 'Approve');
        PaymentChangeReqTable.SetRange("Request Type", 'Combine');

        // Debug: Check if filtered records exist
        if not PaymentChangeReqTable.FindSet() then begin
            Message('No matching records found for Contract ID: %1, Tenant ID: %2, ID: %3',
                Rec."Contract ID", Rec."Tenant ID", Rec."ID");
            exit;
        end
        else begin
            // Process the filtered records
            repeat
                // Debug: Log each record being processed
                Message('Processing Record: Contract ID: %1, Tenant ID: %2, ID: %3',
                    PaymentChangeReqTable."Contract ID",
                    PaymentChangeReqTable."Tenant ID", PaymentChangeReqTable."ID");

                // Fetch the last payment series if any
                PaymentModeTable.Reset(); // Reset to clear filters
                if PaymentModeTable.FindLast() then
                    payseries := PaymentModeTable."Payment Series";

                Clear(PaymentModeTable);

                Combineseries := PaymentChangeReqTable."Payment Series";

                // Fetch the next sequence number and generate the new payment code
                SequenceNo := GetNextSequenceNo();
                NewPaymentCode := GeneratePaymentCode(SequenceNo);




                // Check if the record exists in the Payment Mode table
                if PaymentModeTable.Get(PaymentChangeReqTable."ID") then begin
                    // If record exists, modify it
                    PaymentModeTable."Amount Including VAT" := PaymentChangeReqTable."Change Amount";
                    PaymentModeTable.Amount := PaymentChangeReqTable.Amount;
                    PaymentModeTable."VAT Amount" := PaymentChangeReqTable."Vat Amount";
                    PaymentModeTable."Due Date" := PaymentChangeReqTable."Due Date";

                    // Log modification for debugging
                    Message('Modified existing record: Contract ID: %1, Tenant ID: %2, ID: %3',
                        PaymentModeTable."Contract ID",
                        PaymentModeTable."Tenant ID", PaymentModeTable."ID");

                    PaymentModeTable.Modify(true);
                end
                else begin
                    // If record doesn't exist, insert a new one
                    PaymentModeTable.Init();
                    PaymentModeTable."Contract ID" := PaymentChangeReqTable."Contract ID";
                    PaymentModeTable."Tenant ID" := PaymentChangeReqTable."Tenant ID";
                    PaymentModeTable."ID" := PaymentChangeReqTable."ID";
                    PaymentModeTable."Amount Including VAT" := PaymentChangeReqTable."Change Amount";
                    PaymentModeTable.Amount := PaymentChangeReqTable.Amount;
                    PaymentModeTable."VAT Amount" := PaymentChangeReqTable."Vat Amount";
                    PaymentModeTable."Due Date" := PaymentChangeReqTable."Due Date";
                    PaymentModeTable."Payment Mode" := PaymentChangeReqTable."Payment mode";
                    PaymentModeTable."Payment Series" := NewPaymentCode;


                    // Log insertion for debugging
                    Message('Inserted new record: Contract ID: %1, Tenant ID: %2, ID: %3',
                        PaymentModeTable."Contract ID",
                        PaymentModeTable."Tenant ID", PaymentModeTable."ID");

                    PaymentModeTable.Insert(true);
                    Clear(PaymentModeTable);
                end;

            until PaymentChangeReqTable.Next() = 0;
        end;

        Message('Processing complete.');
    end;



    // Generates a new payment code with a padded sequence number
    local procedure GeneratePaymentCode(SequenceNumber: Integer): Code[20]
    begin
        exit('PAY' + PadStr(Format(SequenceNumber), 2, '0')); // Format as PAY000001
    end;

    // Pads a string to a specified length with a specified character
    local procedure PadStr(Input: Text[20]; Length: Integer; PaddingChar: Char): Text[20]
    begin
        while StrLen(Input) < Length do
            Input := PaddingChar + Input;
        exit(Input);
    end;

    // Gets the next sequence number for the Payment Series
    local procedure GetNextSequenceNo(): Integer
    var
        MaxSequence: Integer;
        LastSequence: Text[10];
        MergedRecord: Record "Payment Mode2";
    begin
        MergedRecord.Reset();
        MergedRecord.SetRange("Contract ID", Rec."Contract ID");

        if MergedRecord.FindSet() then begin
            repeat
                // Extract the numeric part of the Payment Series
                LastSequence := CopyStr(MergedRecord."Payment Series", 4, StrLen(MergedRecord."Payment Series"));
                if Evaluate(MaxSequence, LastSequence) and (MaxSequence > MaxSequence) then
                    MaxSequence := MaxSequence;
            until MergedRecord.Next() = 0;
        end else
            MaxSequence := 0; // Default to 0 if no records are found

        exit(MaxSequence + 1);
    end;



    // procedure ProcessCombineRequest()
    // var
    //     PaymentChangeReqTable: Record "Approval Payment Request"; // Replace with your actual table name
    //     PaymentModeTable: Record "Payment Mode2"; // Replace with your actual table name
    //     payseries: Text[100];
    //     Paymentseries: Text[100];
    // begin
    //     // Ensure the current record is properly copied
    //     // if Rec.IsEmpty() then begin
    //     //     Message('No record selected.');
    //     //     exit;
    //     // end;

    //     // Debug: Log current record IDs
    //     Message('Processing Record for: Contract ID: %1, Tenant ID: %2, Proposal ID: %3',
    //         Rec."Contract ID", Rec."Tenant ID", Rec."Proposal ID");

    //     // Filter PaymentChangeReqTable based on the current record's IDs
    //     PaymentChangeReqTable.Reset();
    //     PaymentChangeReqTable.SetRange("Contract ID", Rec."Contract ID");
    //     PaymentChangeReqTable.SetRange("Tenant ID", Rec."Tenant ID");
    //     PaymentChangeReqTable.SetRange("Proposal ID", Rec."Proposal ID");
    //     PaymentChangeReqTable.SetRange("Payment Series", Rec."Payment Series");
    //     PaymentChangeReqTable.SetRange(Status, 'Approve');
    //     PaymentChangeReqTable.SetRange("Request Type", 'Combine');

    //     // Debug: Check if filtered records exist
    //     if not PaymentChangeReqTable.FindSet() then begin
    //         Message('No matching records found for Contract ID: %1, Tenant ID: %2, Proposal ID: %3',
    //             Rec."Contract ID", Rec."Tenant ID");
    //         exit;
    //     end
    //     else begin

    //         // Process the filtered records
    //         repeat
    //             // Debug: Log each record being processed
    //             Message('Processing Record: Contract ID: %1, Tenant ID: %2, Proposal ID: %3, Changed Payment Series: %4',
    //                 PaymentChangeReqTable."Contract ID",
    //                 PaymentChangeReqTable."Tenant ID",
    //                 PaymentChangeReqTable."Proposal ID",
    //                 PaymentChangeReqTable."Changed Payment Series", PaymentChangeReqTable."Payment Series");

    //             // Fetch the last payment series if any
    //             PaymentModeTable.Reset(); // Reset to clear filters
    //             if PaymentModeTable.FindLast() then
    //                 payseries := PaymentModeTable."Payment Series";

    //             Clear(PaymentModeTable);

    //             // Insert new record in Payment Mode table
    //             PaymentModeTable.Init();
    //             PaymentModeTable."Contract ID" := PaymentChangeReqTable."Contract ID";
    //             PaymentModeTable."Tenant ID" := PaymentChangeReqTable."Tenant ID";
    //             PaymentModeTable."Proposal ID" := PaymentChangeReqTable."Proposal ID";
    //             PaymentModeTable."Payment Series" := PaymentChangeReqTable."Changed Payment Series"; // Example field
    //             PaymentModeTable."Amount Including VAT" := PaymentChangeReqTable."Change Amount";
    //             PaymentModeTable.Amount := PaymentChangeReqTable.Amount;
    //             PaymentModeTable."VAT Amount" := PaymentChangeReqTable."Vat Amount";
    //             PaymentModeTable."Due Date" := PaymentChangeReqTable."Due Date";
    //             Paymentseries := PaymentChangeReqTable."Payment Series";

    //             PaymentModeTable.Insert(true);


    //             PaymentModeTable.Reset(); // Reset to clear previous filters
    //             PaymentModeTable.SetRange("Payment Series", Rec."Payment Series"); // Filter on the current Payment Series

    //             if PaymentModeTable.FindSet() then begin
    //                 repeat
    //                     PaymentModeTable."Payment Status" := PaymentModeTable."Payment Status"::Cancelled;
    //                     PaymentModeTable.Modify();
    //                 until PaymentModeTable.Next() = 0;
    //             end;

    //             Clear(PaymentModeTable);

    //         until PaymentChangeReqTable.Next() = 0;
    //     end;

    //     Message('Processing complete.');
    // end;



    // procedure ProcessSplitRequest()
    // var
    //     PaymentChangeReqTable: Record "Approval Payment Request"; // Replace with your actual table name
    //     PaymentModeTable: Record "Payment Mode2"; // Replace with your actual table name
    //     payseries: Text[100];
    //     Paymentseries: Text[100];
    // begin
    //     // Ensure the current record is properly copied
    //     // if Rec.IsEmpty() then begin
    //     //     Message('No record selected.');
    //     //     exit;
    //     // end;

    //     // Debug: Log current record IDs
    //     Message('Processing Record for: Contract ID: %1, Tenant ID: %2, Proposal ID: %3',
    //         Rec."Contract ID", Rec."Tenant ID", Rec."Proposal ID");

    //     // Filter PaymentChangeReqTable based on the current record's IDs
    //     PaymentChangeReqTable.Reset();
    //     PaymentChangeReqTable.SetRange("Contract ID", Rec."Contract ID");
    //     PaymentChangeReqTable.SetRange("Tenant ID", Rec."Tenant ID");
    //     PaymentChangeReqTable.SetRange("Proposal ID", Rec."Proposal ID");
    //     PaymentChangeReqTable.SetRange("Payment Series", Rec."Payment Series");
    //     PaymentChangeReqTable.SetRange(Status, 'Approve');
    //     PaymentChangeReqTable.SetRange("Request Type", 'Split');

    //     // Debug: Check if filtered records exist
    //     if not PaymentChangeReqTable.FindSet() then begin
    //         Message('No matching records found for Contract ID: %1, Tenant ID: %2, Proposal ID: %3',
    //             Rec."Contract ID", Rec."Tenant ID");
    //         exit;
    //     end
    //     else begin

    //         // Process the filtered records
    //         repeat
    //             // Debug: Log each record being processed
    //             Message('Processing Record: Contract ID: %1, Tenant ID: %2, Proposal ID: %3, Changed Payment Series: %4',
    //                 PaymentChangeReqTable."Contract ID",
    //                 PaymentChangeReqTable."Tenant ID",
    //                 PaymentChangeReqTable."Proposal ID",
    //                 PaymentChangeReqTable."Changed Payment Series");

    //             // Fetch the last payment series if any
    //             PaymentModeTable.Reset(); // Reset to clear filters
    //             if PaymentModeTable.FindLast() then
    //                 payseries := PaymentModeTable."Payment Series";

    //             Clear(PaymentModeTable);

    //             // Insert new record in Payment Mode table
    //             PaymentModeTable.Init();
    //             PaymentModeTable."Contract ID" := PaymentChangeReqTable."Contract ID";
    //             PaymentModeTable."Tenant ID" := PaymentChangeReqTable."Tenant ID";
    //             PaymentModeTable."Proposal ID" := PaymentChangeReqTable."Proposal ID";
    //             PaymentModeTable."Payment Series" := PaymentChangeReqTable."Changed Payment Series"; // Example field
    //             PaymentModeTable."Amount Including VAT" := PaymentChangeReqTable."Change Amount";
    //             PaymentModeTable.Amount := PaymentChangeReqTable.Amount;
    //             PaymentModeTable."VAT Amount" := PaymentChangeReqTable."Vat Amount";
    //             PaymentModeTable."Due Date" := PaymentChangeReqTable."Due Date";
    //             Paymentseries := PaymentChangeReqTable."Payment Series";

    //             PaymentModeTable.Insert(true);


    //             PaymentModeTable.Reset(); // Reset to clear previous filters
    //             PaymentChangeReqTable.SetRange("Payment Series", Rec."Payment Series"); // Filter on the current Payment Series

    //             if PaymentModeTable.FindSet() then begin
    //                 PaymentModeTable."Payment Status" := PaymentModeTable."Payment Status"::Cancelled;
    //                 PaymentModeTable.Modify();
    //             end;
    //             Clear(PaymentModeTable);
    //         until PaymentChangeReqTable.Next() = 0;
    //     end;

    //     Message('Processing complete.');
    // end;


    // procedure ProcessChangeDepositbankRequest()
    // var
    //     PaymentChangeReqTable: Record "Approval Payment Request"; // Replace with your actual table name
    //     PaymentModeTable: Record "Payment Mode2"; // Replace with your actual table name
    //     payseries: Text[100];
    //     Depositbank: Text[100];
    // begin
    //     // Debug: Log current record IDs
    //     // Message('Processing Record for: Contract ID: %1, Tenant ID: %2, Proposal ID: %3',
    //     //     Rec."Contract ID", Rec."Tenant ID", Rec."Proposal ID");

    //     // Filter PaymentChangeReqTable based on the current record's IDs
    //     PaymentChangeReqTable.Reset();
    //     PaymentChangeReqTable.SetRange("Contract ID", Rec."Contract ID");
    //     PaymentChangeReqTable.SetRange("Tenant ID", Rec."Tenant ID");
    //     PaymentChangeReqTable.SetRange("Proposal ID", Rec."Proposal ID");
    //     PaymentChangeReqTable.SetRange("Payment Series", Rec."Payment Series");
    //     PaymentChangeReqTable.SetRange(Status, 'Approve');
    //     PaymentChangeReqTable.SetRange("Request Type", 'Deposit Bank');

    //     // Debug: Check if filtered records exist
    //     if not PaymentChangeReqTable.FindSet() then begin
    //         Message('No matching records found for Contract ID: %1, Tenant ID: %2, Proposal ID: %3',
    //             Rec."Contract ID", Rec."Tenant ID");
    //         exit;
    //     end
    //     else begin
    //         // Debug: Log each record being processed
    //         Message('Processing Record: Contract ID: %1, Tenant ID: %2, Proposal ID: %3, Changed Payment Series: %4',
    //             PaymentChangeReqTable."Contract ID",
    //             PaymentChangeReqTable."Tenant ID",
    //             PaymentChangeReqTable."Proposal ID",
    //             PaymentChangeReqTable."Changed Payment Series");

    //         if PaymentModeTable.FindSet() then begin
    //             PaymentModeTable."Deposit Bank" := PaymentChangeReqTable."Deposit Bank";
    //             PaymentModeTable.Modify();
    //             Clear(PaymentModeTable);

    //         end;
    //     end;

    //     Message('Processing complete.');

    // end;


    // procedure ProcessChangePaymentmodeRequest()
    // var
    //     PaymentChangeReqTable: Record "Approval Payment Request"; // Replace with your actual table name
    //     PaymentModeTable: Record "Payment Mode2"; // Replace with your actual table name
    //     payseries: Text[100];
    //     Depositbank: Text[100];
    // begin

    //     // Filter PaymentChangeReqTable based on the current record's IDs
    //     PaymentChangeReqTable.Reset();
    //     PaymentChangeReqTable.SetRange("Contract ID", Rec."Contract ID");
    //     PaymentChangeReqTable.SetRange("Tenant ID", Rec."Tenant ID");
    //     PaymentChangeReqTable.SetRange("Proposal ID", Rec."Proposal ID");
    //     PaymentChangeReqTable.SetRange("Payment Series", Rec."Payment Series");
    //     PaymentChangeReqTable.SetRange(Status, 'Approve');
    //     PaymentChangeReqTable.SetRange("Request Type", 'Payment Mode');

    //     // Debug: Check if filtered records exist
    //     if not PaymentChangeReqTable.FindSet() then begin
    //         Message('No matching records found for Contract ID: %1, Tenant ID: %2, Proposal ID: %3',
    //             Rec."Contract ID", Rec."Tenant ID");
    //         exit;
    //     end
    //     else begin
    //         // Debug: Log each record being processed
    //         Message('Processing Record: Contract ID: %1, Tenant ID: %2, Proposal ID: %3, Changed Payment Series: %4',
    //             PaymentChangeReqTable."Contract ID",
    //             PaymentChangeReqTable."Tenant ID",
    //             PaymentChangeReqTable."Proposal ID",
    //             PaymentChangeReqTable."Changed Payment Series");

    //         if PaymentModeTable.FindSet() then begin
    //             PaymentModeTable."Payment Mode" := PaymentChangeReqTable."Payment Mode";
    //             PaymentModeTable.Modify();
    //             Clear(PaymentModeTable);

    //         end;
    //     end;

    //     Message('Processing complete.');

    // end;


}