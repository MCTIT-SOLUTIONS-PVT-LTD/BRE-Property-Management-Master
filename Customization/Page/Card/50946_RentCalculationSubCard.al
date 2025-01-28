page 50946 "Rent Calculation SubCard"
{
    PageType = ListPart;
    ApplicationArea = All;
    DeleteAllowed = true;
    // UsageCategory = Administration;
    SourceTable = "Rent Calculation Subpage";
    Caption = 'Rent Calculation';


    layout
    {
        area(Content)
        {
            repeater(Group)

            {

                field("Year"; Rec."Year")
                {
                    ApplicationArea = All;
                    Caption = 'Year';
                    ToolTip = 'Enter the Year.';
                }
                field("Period Start Date"; Rec."Period Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }

                field("Period End Date"; Rec."Period End Date")
                {
                    ApplicationArea = All;
                    Caption = 'End Date';


                }

                field("Number of Days"; Rec."Number of Days")
                {
                    ApplicationArea = All;
                    Caption = 'Number of Days';



                }

                field("Final Annual Amount"; Rec."Final Annual Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Final Annual Amount';
                    Editable = true;


                }

                field("Yearly No. of Installment"; Rec."Yearly No. of Installment")
                {
                    ApplicationArea = All;
                    Caption = 'Yearly No. of Instalment';
                    Editable = true;
                    // trigger OnValidate()
                    // var
                    //     calculateinstallmentstotal: Codeunit CalculateNumberOfInstallments;
                    // begin
                    //     // CalculateTotals();
                    //     calculateinstallmentstotal.CalculateInstallments(Rec);
                    // end;

                }

                // field("Proposal ID"; Rec."Proposal ID")
                // {
                //     ApplicationArea = All;
                //     Editable = false; // The ID is not editable since it's auto-incrementing
                //     Lookup = true;
                //     Visible = false;
                // }

                field("Tenant ID"; Rec."Tenant ID")
                {
                    ApplicationArea = All;
                    Editable = false; // The ID is not editable since it's auto-incrementing
                    Lookup = true;
                    Visible = false;
                }

                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                    Editable = false; // The ID is not editable since it's auto-incrementing
                    Lookup = true;
                    Visible = false;
                }


                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                    Caption = 'VAT %';
                    ToolTip = 'Enter the VAT %.';
                    Editable = false;
                }



            }




            group(Group2)
            {
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Total Amount';
                    ToolTip = 'Enter the Total Amount.';


                    // trigger OnValidate()
                    // begin
                    //     CalculateTotals();
                    // end;

                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Amount';
                    ToolTip = 'Enter the VAT Amount.';
                    Visible = false;
                }

                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    Caption = 'Amount Including VAT';
                    ToolTip = 'Enter the Amount Including VAT.';
                    Visible = false;
                }

                field("Secondary Item Type"; Rec."Secondary Item Type")
                {
                    ApplicationArea = All;
                    Caption = 'Secondary Item Type';
                    ToolTip = 'Enter the Secondary Item Type.';
                    Visible = false;
                }




                // field("Total Installment"; Rec."Total Installment")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Total Installment';
                //     ToolTip = 'Enter the Total Installment.';
                //     Editable = false;


                //     // trigger OnValidate()
                //     // begin
                //     //     CalculateTotals();
                //     // end;

                // }


                field("Link"; Rec."Link")
                {
                    ApplicationArea = All;
                    Caption = 'Link';
                    ToolTip = 'Enter the Link.';
                    Editable = false;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        TargetPageID: Integer;
                        TargetRecord: Record "Rent Calculation";
                        RevenueStructure: Record "Rent Calculation Subpage"; // Main table
                        InstallmentStructure: Record "Rent Calculation Subpage2"; // Second subgrid table
                        StartDate: Date;
                        EndDate: Date;
                        AnnualAmount: Decimal;
                        NumInstallments: Integer;
                        InstallmentAmount: Decimal;
                        InstallmentStartDate: Date;
                        InstallmentEndDate: Date;
                        DueDate: Date;
                        DaysPerInstallment: Integer;
                        InstallmentNumber: Integer;
                        DaysInYear: Integer;
                        IsLeapYear: Boolean;
                        YearCounter: Integer;
                        TotalYears: Integer;
                        VATAmount: Decimal;
                        AmountandVAT: Decimal;
                        Totalamount: Integer;
                        Installment: Integer;
                        VATPer: Integer;
                        VATAmount2: Decimal;
                        TotalCalculatedAmount: Decimal;
                        LastInstallmentAmount: Decimal;
                        InstallmentAmount2: Decimal;

                    begin

                        InstallmentStructure.SetRange("RC ID", Rec."RC ID");
                        if InstallmentStructure.FindSet() then begin
                            InstallmentStructure.DeleteAll();
                        end;
                        // Set filters to fetch related records
                        // RevenueStructure.SetRange("Proposal ID", Rec."Proposal ID");
                        RevenueStructure.SetRange("Tenant ID", Rec."Tenant ID");
                        RevenueStructure.SetRange("Contract ID", Rec."Contract ID");
                        RevenueStructure.SetRange("RC ID", Rec."RC ID");
                        //TargetRecord.SetRange("Proposal ID", Rec."Proposal ID");
                        TargetRecord.SetRange("Contract ID", Rec."Contract ID");
                        TargetRecord.SetRange("Tenant ID", Rec."Tenant ID");
                        TargetRecord.SetRange("RC ID", Rec."RC ID");


                        if RevenueStructure.FindSet() then begin
                            // Loop through Revenue Structure to calculate and populate or update Installment Structure
                            repeat

                                NumInstallments := RevenueStructure."Yearly No. of Installment";

                                AnnualAmount := RevenueStructure."Final Annual Amount";
                                StartDate := RevenueStructure."Period Start Date";
                                EndDate := RevenueStructure."Period End Date";
                                //VATAmount := RevenueStructure."VAT Amount";
                                VATPer := RevenueStructure."VAT %";
                                TotalYears := RevenueStructure."Year";
                                TargetPageID := RevenueStructure."RC ID";
                                if TargetRecord.FindSet() then begin
                                    Installment := TargetRecord."Number of Installments";

                                end;





                                //  InstallmentAmount := RevenueStructure."Final Annual Amount" / RevenueStructure."Yearly No. of Installment";

                                InstallmentAmount := ROUND(RevenueStructure."Final Annual Amount" / RevenueStructure."Yearly No. of Installment", 0.01);

                                TotalCalculatedAmount := InstallmentAmount * RevenueStructure."Yearly No. of Installment";  // 1666.67*3 = 5000.01
                                LastInstallmentAmount := TotalCalculatedAmount - RevenueStructure."Final Annual Amount"; // 5000.01 - 5000 = 0.01
                                InstallmentAmount2 := InstallmentAmount - LastInstallmentAmount;   // 1666.67 - 0.01 = 1666.66

                                for InstallmentNumber := 1 to RevenueStructure."Yearly No. of Installment" do begin
                                    InstallmentStructure.SetRange("RC ID", TargetPageID);
                                    InstallmentStructure.SetRange("Year", TotalYears);
                                    InstallmentStructure.SetRange("Installment No.", InstallmentNumber);

                                    if InstallmentStructure.FindFirst() then begin
                                        // Update existing record

                                        if InstallmentNumber = 1 then begin
                                            InstallmentStructure.Amount := InstallmentAmount2;
                                            InstallmentStructure."Installment Start Date" := RevenueStructure."Period Start Date";
                                            InstallmentStructure."Installment End Date" := RevenueStructure."Period Start Date" + ROUND(RevenueStructure."Number of Days" / RevenueStructure."Yearly No. of Installment", 1, '<') - 1;
                                        end else begin
                                            InstallmentStructure.Amount := InstallmentAmount;
                                            InstallmentStructure."Installment Start Date" := RevenueStructure."Period Start Date" + (InstallmentNumber - 1) * ROUND(RevenueStructure."Number of Days" / RevenueStructure."Yearly No. of Installment", 1, '<');

                                            InstallmentStructure."Installment End Date" := RevenueStructure."Period Start Date" + InstallmentNumber * ROUND(RevenueStructure."Number of Days" / RevenueStructure."Yearly No. of Installment", 1, '<');
                                        end;

                                        // TotalCalculatedAmount := InstallmentAmount * RevenueStructure."Yearly No. of Installment";  // 1666.67*3 = 5000.01
                                        // LastInstallmentAmount := TotalCalculatedAmount - RevenueStructure."Final Annual Amount"; // 5000.01 - 5000 = 0.01
                                        // InstallmentAmount2 := InstallmentAmount - LastInstallmentAmount;





                                        InstallmentStructure.Modify();
                                    end else begin
                                        // Insert new record
                                        InstallmentStructure.Init();
                                        InstallmentStructure."RC ID" := TargetPageID;
                                        // InstallmentStructure."Proposal ID" := RevenueStructure."Proposal ID";
                                        InstallmentStructure."Tenant ID" := RevenueStructure."Tenant ID";
                                        InstallmentStructure."Contract ID" := RevenueStructure."Contract ID";

                                        // InstallmentStructure."VAT Amount" := VATAmount2;
                                        InstallmentStructure."VAT %" := VATPer;
                                        InstallmentStructure."Secondary Item Type" := RevenueStructure."Secondary Item Type";
                                        InstallmentStructure."Year" := TotalYears;
                                        InstallmentStructure."Installment No." := InstallmentNumber;
                                        // InstallmentStructure.Amount := InstallmentAmount;
                                        if InstallmentNumber = RevenueStructure."Yearly No. of Installment" then begin
                                            InstallmentStructure.Amount := InstallmentAmount2;
                                        end else begin
                                            InstallmentStructure.Amount := InstallmentAmount;
                                        end;
                                        if InstallmentStructure."VAT %" = 1 then
                                            InstallmentStructure."VAT %" := 5
                                        else
                                            InstallmentStructure."VAT %" := 0;

                                        InstallmentStructure."VAT Amount" := InstallmentStructure.Amount * (InstallmentStructure."VAT %" / 100);
                                        InstallmentStructure."Amount Including VAT" := InstallmentStructure.Amount + InstallmentStructure."VAT Amount";



                                        IF InstallmentNumber = 1 THEN BEGIN
                                            InstallmentStructure."Installment Start Date" := RevenueStructure."Period Start Date";
                                            InstallmentStructure."Installment End Date" :=
                                                RevenueStructure."Period Start Date" +
                                                ROUND(RevenueStructure."Number of Days" / RevenueStructure."Yearly No. of Installment", 1, '<') - 1;
                                        END ELSE BEGIN
                                            InstallmentStructure."Installment Start Date" :=
                                                RevenueStructure."Period Start Date" +
                                                (InstallmentNumber - 1) * ROUND(RevenueStructure."Number of Days" / RevenueStructure."Yearly No. of Installment", 1, '<');
                                            InstallmentStructure."Installment End Date" :=
                                                RevenueStructure."Period Start Date" +
                                                InstallmentNumber * ROUND(RevenueStructure."Number of Days" / RevenueStructure."Yearly No. of Installment", 1, '<') - 1;
                                        END;


                                        // Ensure the last installment end date matches the full period end date
                                        IF InstallmentNumber = RevenueStructure."Yearly No. of Installment" THEN
                                            InstallmentStructure."Installment End Date" := RevenueStructure."Period End Date";




                                        // InstallmentStructure."Installment Start Date" := StartDate + (InstallmentNumber - 1) * ROUND(RevenueStructure."Number of Days" / NumInstallments, 1, '<');
                                        // InstallmentStructure."Installment End Date" := StartDate + InstallmentNumber * ROUND(RevenueStructure."Number of Days" / NumInstallments, 1, '<');
                                        InstallmentStructure."Due Date" := InstallmentStructure."Installment Start Date";
                                        InstallmentStructure.Insert();
                                        //Clear(InstallmentStructure);
                                    end;


                                    TargetRecord.SetRange("Contract ID", Rec."Contract ID");
                                    // TargetRecord.SetRange("Proposal ID", RevenueStructure."Proposal ID");
                                    TargetRecord.SetRange("RC ID", RevenueStructure."RC ID");
                                    TargetRecord.SetRange("Secondary Item Type", RevenueStructure."Secondary Item Type");



                                    if TargetRecord.FindSet() then begin
                                        repeat
                                            // Calculate or retrieve the Installment value

                                            Installment := TargetRecord."Number of Installments";
                                            // Update the existing record
                                            TargetRecord."Number of Installments" := Installment;
                                            TargetRecord.Modify();
                                        until TargetRecord.Next() = 0;
                                    end else begin
                                        // If no records exist, insert a new record
                                        TargetRecord.Init();
                                        // TargetRecord."Proposal ID" := RevenueStructure."Proposal ID";
                                        TargetRecord."Contract ID" := RevenueStructure."Contract ID";
                                        TargetRecord."RC ID" := RevenueStructure."RC ID";
                                        TargetRecord."Secondary Item Type" := RevenueStructure."Secondary Item Type";
                                        TargetRecord."Number of Installments" := Installment; // Ensure Installment is correctly initialized or calculated
                                        TargetRecord.Insert();
                                        Clear(TargetRecord);
                                    end;

                                    Clear(InstallmentStructure);


                                end;


                            until RevenueStructure.Next() = 0;



                            // if InstallmentStructure.FindSet() then begin
                            //     repeat
                            //         if InstallmentStructure."Installment No." > RevenueStructure."Yearly No. of Installment" then
                            //             InstallmentStructure.Delete();
                            //     until InstallmentStructure.Next() = 0;
                            // end;

                        end else
                            Error('No records found in the Revenue Structure.');
                    end;

                }
            }

        }


    }






    // local procedure CalcVATAndTotal()
    // var
    //     vatPer: Integer;
    //     InstallmentStructure: Record "Revenue Structure Subpage1";
    // begin
    //     if InstallmentStructure."VAT %" = InstallmentStructure."VAT %"::"5" then
    //         vatPer := 5
    //     else
    //         vatPer := 0;

    //     InstallmentStructure."VAT Amount" := InstallmentStructure.Amount * (vatPer / 100);

    // end;


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


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Contract ID" := ContractID;
        Rec."Tenant ID" := tenantID;
        // Rec."Proposal ID" := proposalID;
        // RevenuestructureID := RevenuestructureRec."RS ID"; // Automatically generated ID

    end;

    var
        ContractID: Integer;
        proposalID: Integer;
        tenantID: Code[20];






}









