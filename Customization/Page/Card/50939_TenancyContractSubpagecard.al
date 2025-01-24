page 50939 "Tenancy Contract SubPage Card"
{
    PageType = ListPart;
    ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Tenancy Contract Subpage";
    Caption = 'Other Payments';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("Secondary Item Type"; Rec."Secondary Item Type")
                {
                    ApplicationArea = All;
                    Caption = 'Secondary Item Type';
                    ToolTip = 'Enter the Secondary Item Type.';

                }
                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount';

                }

                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                    // trigger OnValidate()
                    // begin
                    //     CurrPage.Update(); // Refresh the page to apply changes immediately
                    // end;

                }

                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Amount';
                }

                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    Caption = 'Amount Including VAT';
                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                    Lookup = true;
                }

                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                    Lookup = true;
                }

                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Type';
                    ToolTip = 'Enter the Payment Type.';

                    // trigger OnValidate()
                    // begin
                    //     if Rec."Payment Type" = Rec."Payment Type"::Installment then
                    //         isvisible := true
                    //     else
                    //         isvisible := false
                    // end;


                }


                // field("No. of Installments"; Rec."No. of Installments")
                // {
                //     ApplicationArea = All;
                //     Caption = 'No. of Installments';
                // }

                field("Generate Payment Schedule"; Rec."Generate Payment Schedule")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    //Visible = isvisible;

                    // trigger OnValidate()
                    // begin
                    //     CurrPage.Update(true); // Refresh the page to apply visibility changes
                    // end;




                    trigger OnDrillDown()
                    var
                        TargetPageID: Integer;
                        TargetRecord: Record "Revenue Structure"; // Replace with the actual table name
                        StartDate: Date;
                        EndDate: Date;
                        AnnualAmount: Decimal;
                        NumInstallments: Integer;
                        PeriodStartDate: Date;
                        PeriodEndDate: Date;
                        YearCounter: Integer;
                        NumDays: Integer;
                        RevenueStructure: Record "Revenue Structure Subpage";
                        InstallmentStructure: Record "Revenue Structure Subpage1"; // Second Table
                        InstallmentStartDate, InstallmentEndDate, InstallmentDueDate : Date;
                        PaymentMode: Option;
                        InstallmentNumber: Integer;
                        InstallmentYearcounter: Integer;
                        InstallmentAmount: Decimal;
                        DaysInPeriod, DaysPerInstallment : Integer;
                        CurrentStartDate: Date;
                        CurrentEndDate: Date;
                        InstallmentAnnualAmount: Decimal;
                        i: Integer;
                        DaysInYear: Integer;
                        IsLeapYear: Boolean;
                        Year: Integer;
                        RemainingInstallments: Integer;
                        InsertedInstallments: Integer;
                        VATAmount: Decimal;
                        VATandAmount: Decimal;
                        IsLeapYearInRange: Boolean;
                        CurrentYear: Integer;
                        StartYear: Integer;
                        EndYear: Integer;
                        LeapDate: Date;
                        Revenuestructureid: Integer;
                    //LeaseRecord: Record "Lease Proposal Details";


                    begin

                        if Rec."Payment Type" = Rec."Payment Type"::Installment then begin


                            // TargetRecord.SetRange("Proposal ID", Rec."ProposalID");
                            TargetRecord.SetRange("Contract ID", Rec."ContractID");
                            TargetRecord.SetRange("Secondary Item Type", Rec."Secondary Item Type");
                            TargetRecord.SetRange("Tenant ID", Rec."TenantID");

                            if TargetRecord.FindSet() then begin
                                TargetRecord."Contract Start Date" := Rec."Start Date";
                                TargetRecord."Contract End Date" := Rec."End Date";
                                TargetRecord."Amount" := Rec."Amount";
                                // TargetRecord."Number of Installments" := Rec."No. of Installments";
                                TargetRecord."VAT Amount" := Rec."VAT Amount";
                                TargetRecord."Amount Including VAT" := Rec."Amount Including VAT";
                                TargetRecord."VAT %" := Rec."VAT %";
                                TargetRecord.Modify();
                            end else begin
                                TargetRecord.Init();
                                // TargetRecord."Proposal ID" := Rec."ProposalID";
                                TargetRecord."Contract ID" := Rec."ContractID";
                                TargetRecord."Tenant ID" := Rec."TenantID";
                                TargetRecord."Secondary Item Type" := Rec."Secondary Item Type";
                                TargetRecord."Contract Start Date" := Rec."Start Date";
                                TargetRecord."Contract End Date" := Rec."End Date";
                                TargetRecord."Amount" := Rec."Amount";
                                // TargetRecord."Number of Installments" := Rec."No. of Installments";
                                TargetRecord."VAT Amount" := Rec."VAT Amount";
                                TargetRecord."Amount Including VAT" := Rec."Amount Including VAT";
                                TargetRecord."VAT %" := Rec."VAT %";
                                TargetRecord.Insert();


                                StartDate := TargetRecord."Contract Start Date";
                                EndDate := TargetRecord."Contract End Date";
                                AnnualAmount := TargetRecord."Amount";
                                //NumInstallments := TargetRecord."Number of Installments";
                                // VATAmount := TargetRecord."VAT Amount";
                                // VATandAmount := TargetRecord."Amount Including VAT";

                                //TargetRecord.Modify();





                                if (StartDate = 0D) or (EndDate = 0D) or (AnnualAmount = 0) then
                                    Error('Start Date, End Date, and Amount must be populated.');

                                YearCounter := 1;
                                PeriodStartDate := StartDate;




                                while PeriodStartDate <= EndDate do begin
                                    RevenueStructure.Init();
                                    RevenueStructure."RS ID" := TargetRecord."RS ID";
                                    //RevenueStructure."Proposal Id" := TargetRecord."Proposal ID";
                                    RevenueStructure."Tenant Id" := TargetRecord."Tenant ID";
                                    RevenueStructure."Contract ID" := TargetRecord."Contract ID";
                                    RevenueStructure."Year" := YearCounter;
                                    RevenueStructure."Period Start Date" := PeriodStartDate;

                                    RevenueStructure."VAT Amount" := TargetRecord."VAT Amount";
                                    RevenueStructure."Amount Including VAT" := TargetRecord."Amount Including VAT";
                                    RevenueStructure."Secondary Item Type" := TargetRecord."Secondary Item Type";
                                    RevenueStructure."VAT %" := TargetRecord."VAT %";


                                    if PeriodStartDate + 365 > EndDate then
                                        PeriodEndDate := EndDate
                                    else
                                        PeriodEndDate := PeriodStartDate + 365 - 1;

                                    RevenueStructure."Period End Date" := PeriodEndDate;

                                    NumDays := PeriodEndDate - PeriodStartDate + 1;

                                    // Check if February 29 falls within the range
                                    StartYear := Date2DMY(PeriodStartDate, 3); // Extract the year of PeriodStartDate
                                    EndYear := Date2DMY(PeriodEndDate, 3);    // Extract the year of PeriodEndDate

                                    IsLeapYearInRange := false;

                                    for CurrentYear := StartYear to EndYear do begin
                                        if IsLeapYear(CurrentYear) then begin
                                            LeapDate := DMY2Date(29, 2, CurrentYear); // Generate February 29 date
                                            if (LeapDate >= PeriodStartDate) and (LeapDate <= PeriodEndDate) then begin
                                                IsLeapYearInRange := true;
                                                break; // No need to check further if a leap year is found in range
                                            end;
                                        end;
                                    end;

                                    // Adjust the number of days if a leap year is in range
                                    if IsLeapYearInRange then
                                        NumDays := NumDays + 1;


                                    // RevenueStructure."Number of Days" := NumDays;

                                    // RevenueStructure."Final Annual Amount" := Round(AnnualAmount / (EndDate - StartDate + 1) * 365, 2);
                                    // RevenueStructure."Yearly No. of Installment" := Round(NumInstallments / (EndDate - StartDate + 1) * 365, 2);


                                    // RevenueStructure.Insert();
                                    // // Clear(RevenueStructure);


                                    // PeriodStartDate := PeriodEndDate + 1;
                                    // YearCounter += 1;


                                    // NumDays := PeriodEndDate - PeriodStartDate + 1;
                                    RevenueStructure."Number of Days" := NumDays;


                                    // // Calculate the annual amount based on the number of days in the period
                                    // RevenueStructure."Final Annual Amount" := Round(AnnualAmount / (EndDate - StartDate + 1) * NumDays, 2);

                                    // // Calculate the yearly number of installments, ensuring it does not exceed total installments
                                    // RevenueStructure."Yearly No. of Installment" := Round(NumInstallments / (EndDate - StartDate + 1) * NumDays, 2);

                                    // Ensure the denominator is not zero before division
                                    // if (EndDate - StartDate + 1) <> 0 then begin
                                    //     RevenueStructure."Final Annual Amount" := Round(AnnualAmount / (EndDate - StartDate + 1) * NumDays, 2);
                                    //     RevenueStructure."Yearly No. of Installment" := Round(NumInstallments / (EndDate - StartDate + 1) * NumDays, 2);
                                    // end else begin
                                    //     // Handle the case where the denominator is zero by assigning default values
                                    //     RevenueStructure."Final Annual Amount" := 0;
                                    //     RevenueStructure."Yearly No. of Installment" := 0;
                                    // end;


                                    // Ensure the denominator is not zero before division


                                    // if (EndDate - StartDate + 1) <> 0 then begin
                                    //     RevenueStructure."Final Annual Amount" := Round(AnnualAmount / (EndDate - StartDate + 1) * NumDays, 2);
                                    // end else begin
                                    //     // Handle the case where the denominator is zero by assigning default values
                                    //     RevenueStructure."Final Annual Amount" := 0;
                                    // end;

                                    // // Calculate the Yearly Number of Installments and ensure it divides evenly across the years
                                    // if (EndDate - StartDate + 1) <> 0 then begin
                                    //     RevenueStructure."Yearly No. of Installment" := Round(NumInstallments / (EndDate - StartDate + 1) * NumDays, 2); // Divide equally
                                    // end else begin
                                    //     RevenueStructure."Yearly No. of Installment" := 0; // Handle edge case if YearCounter is 0
                                    // end;



                                    ///  Ensure yearly installments do not exceed the total number of installments
                                    // RemainingInstallments := NumInstallments - InsertedInstallments;
                                    // if RevenueStructure."Yearly No. of Installment" > RemainingInstallments then
                                    //     RevenueStructure."Yearly No. of Installment" := RemainingInstallments;

                                    RevenueStructure.Insert();
                                    RevenueStructure.Modify();
                                    Clear(RevenueStructure);



                                    //  InsertedInstallments += RevenueStructure."Yearly No. of Installment";

                                    PeriodStartDate := PeriodEndDate + 1;
                                    YearCounter += 1;




                                    // Calculate the installment amount
                                    // if RevenueStructure."Yearly No. of Installment" <> 0 then
                                    //     InstallmentAmount := RevenueStructure."Final Annual Amount" / RevenueStructure."Yearly No. of Installment"
                                    // else
                                    //     InstallmentAmount := 0;



                                    // Calculate the installment amount
                                    // InstallmentAmount := RevenueStructure."Final Annual Amount" / RevenueStructure."Yearly No. of Installment";
                                    // VATAmount := TargetRecord."VAT Amount" / TargetRecord."Number of Installments";
                                    // VATandAmount := TargetRecord."Amount Including VAT" / TargetRecord."Number of Installments";


                                    // // Loop through the number of installments to create records in Revenue Payment Schedule
                                    // for InstallmentNumber := 1 to RevenueStructure."Yearly No. of Installment" do begin
                                    //     InstallmentStructure.Init();
                                    //     InstallmentStructure."RS ID" := RevenueStructure."RS ID";
                                    //     InstallmentStructure."Proposal ID" := RevenueStructure."Proposal Id";
                                    //     InstallmentStructure."Tenant ID" := TargetRecord."Tenant ID";
                                    //     InstallmentStructure."Secondary Item Type" := TargetRecord."Secondary Item Type";
                                    //     InstallmentStructure."Year" := RevenueStructure.Year;
                                    //     InstallmentStructure."Installment No." := InstallmentNumber; // You can adjust the format as needed
                                    //     InstallmentStructure.Amount := InstallmentAmount;
                                    //     InstallmentStructure."VAT Amount" := VATAmount;
                                    //     InstallmentStructure."Amount Including VAT" := VATandAmount;

                                    //InstallmentStructure."Installment Start Date" := PeriodStartDate;
                                    // InstallmentStructure."Due Date" := InstallmentStructure."Installment start Date";





                                    // if InstallmentNumber = 1 then begin
                                    //     InstallmentStructure."Installment Start Date" := RevenueStructure."Period Start Date";
                                    //     InstallmentStructure."Installment End Date" :=
                                    //         RevenueStructure."Period Start Date" + (ROUND(RevenueStructure."Number of Days" / RevenueStructure."Yearly No. of Installment", 1, '<')) - 1;
                                    //     InstallmentStructure."Due Date" := InstallmentStructure."Installment Start Date";
                                    // end else begin
                                    //     InstallmentStructure."Installment Start Date" :=
                                    //         RevenueStructure."Period Start Date" + ROUND(RevenueStructure."Number of Days" / RevenueStructure."Yearly No. of Installment", 1, '<');
                                    //     InstallmentStructure."Installment End Date" := RevenueStructure."Period End Date";
                                    //     InstallmentStructure."Due Date" := InstallmentStructure."Installment Start Date";
                                    // end;

                                    // if InstallmentNumber = 1 then begin
                                    //     InstallmentStructure."Installment Start Date" := RevenueStructure."Period Start Date";
                                    //     InstallmentStructure."Installment End Date" := RevenueStructure."Period Start Date" + (ROUND(RevenueStructure."Number of Days" / RevenueStructure."Yearly No. of Installment", 1, '<')) - 1;
                                    //     InstallmentStructure."Due Date" := InstallmentStructure."Installment Start Date";
                                    // end else begin
                                    //     InstallmentStructure."Installment Start Date" := RevenueStructure."Period Start Date" + (InstallmentNumber - 1) * ROUND(RevenueStructure."Number of Days" / RevenueStructure."Yearly No. of Installment", 1, '<');
                                    //     InstallmentStructure."Installment End Date" := RevenueStructure."Period Start Date" + InstallmentNumber * ROUND(RevenueStructure."Number of Days" / RevenueStructure."Yearly No. of Installment", 1, '<') - 1;
                                    //     InstallmentStructure."Due Date" := InstallmentStructure."Installment Start Date";
                                    // end;


                                    // // Set Due Date
                                    // InstallmentStructure."Due Date" := InstallmentStructure."Installment Start Date";



                                    // // Insert the record into Revenue Payment Schedule
                                    // InstallmentStructure.Insert();

                                    if TargetRecord.FindLast() then begin
                                        // If found, get the latest RS ID
                                        Revenuestructureid := TargetRecord."RS ID";
                                    end else begin
                                        // If no record is found, create a new Revenue Structure record
                                        TargetRecord.Init();
                                        TargetRecord.Insert(true);
                                        TargetRecord.Modify(true);  // Insert the new record and generate the RS ID

                                        // Get the newly created RS ID
                                        Revenuestructureid := TargetRecord."RS ID";
                                    end;

                                    Rec."Link" := Revenuestructureid;

                                    // Clear(InstallmentStructure);
                                end;
                                // Clear(RevenueStructure);


                            end;


                            //end;
                            Message('Record are updated in Revenue Structure.Click on the respective link to View the details');
                            // PAGE.RUN(Page::"Revenue Structure List");

                        end
                        else
                            Message('Installment cannot be set for One-Time payment');

                    end;


                }

                field("Link"; Rec."Link")
                {
                    ApplicationArea = All;
                    Caption = 'Link';
                    DrillDown = true;


                    trigger OnDrillDown()
                    var
                        RevenueStructureRec: Record "Revenue Structure";
                        Revenuestructureid: Integer;
                    begin
                        if Rec."Payment Type" = Rec."Payment Type"::Installment then begin

                            //     if Rec."Link" = 0 then begin
                            //         if RevenueStructureRec.FindLast() then begin
                            //             // If found, get the latest RS ID
                            //             Revenuestructureid := RevenueStructureRec."RS ID";
                            //         end else begin
                            //             // If no record is found, create a new Revenue Structure record
                            //             RevenueStructureRec.Init();
                            //             RevenueStructureRec.Insert(true);  // Insert the new record and generate the RS ID

                            //             // Get the newly created RS ID
                            //             Revenuestructureid := RevenueStructureRec."RS ID";
                            //         end;

                            //         Rec."Link" := Revenuestructureid;

                            //         exit;
                            //     end;

                            // Navigate to the Revenue Structure Card page
                            if RevenueStructureRec.Get(Rec."Link") then
                                PAGE.RUN(PAGE::"Revenue Structure Card", RevenueStructureRec)
                            else
                                Message('The related Revenue Structure does not exist.');
                        end
                        else
                            Message('Installment cannot be set for One-Time payment');
                    end;

                }
            }
        }
    }



    local procedure IsLeapYear(Year: Integer): Boolean
    begin
        if (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0)) then
            exit(true);
        exit(false);
    end;



    procedure SetContractID(pContractID: Integer)
    begin
        ContractID := pContractID;
    end;

    procedure SetProposalID(pProposalID: Integer)
    begin
        proposalID := pProposalID;
    end;

    procedure SetTenantID(pTenantID: Code[20])
    begin
        tenantID := pTenantID;
    end;

    // procedure SetStartEndDate(pStartDate: Date; pEndDate: Date)
    // begin
    //     startDate := pStartDate;
    //     endDate := pEndDate;
    // end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.ContractID := ContractID;
        Rec.TenantID := tenantID;
        Rec.ProposalID := proposalID;
        // Rec."Start Date" := startDate;
        // Rec."End Date" := endDate;

    end;

    var
        ContractID: Integer;
        proposalID: Integer;
        tenantID: Code[20];
        startDate: Date;
        endDate: Date;


}



