page 50315 "Lease Proposal Card"
{
    PageType = Card;
    SourceTable = "Lease Proposal Details";
    ApplicationArea = All;
    Caption = 'Lease Proposal';
    Editable = true;

    layout
    {
        area(content)
        {
            group("General Information")
            {
                field("Proposal ID"; rec."Proposal ID")
                {
                    ApplicationArea = All;
                    Editable = false; // Typically auto-generated or set once
                }
                field("Property ID"; rec."Property ID")
                {
                    ApplicationArea = All;
                    Lookup = true; // Enable lookup for Property ID
                }

                field("Property Name"; rec."Property Name")
                {
                    ApplicationArea = All;
                    Caption = 'Property Name';
                    Lookup = true;
                    Editable = false;
                }

                field("Praposal Type Selected"; rec."Praposal Type Selected")
                {
                    ApplicationArea = All;
                    // Lookup = true; // Enable lookup for Property ID
                    Caption = 'Unit Category';
                    trigger OnValidate()
                    begin
                        UpdateUnitEnableState();
                    end;
                }

                field("Unit ID"; rec."Unit ID")
                {
                    ApplicationArea = All;
                    Lookup = true; // Enable lookup for Unit ID
                    Enabled = EnableSingleUnit;


                }
                // label(NoteSingleUnit)
                // {
                //     Caption = 'Note: Once you have selected the Unit ID and have approved the Alert Notification in the Proposal form, the mentioned unit''s status will get updated to "Selected". In order to make it FREE, you need to manually "Decline" the Proposal.';
                //     ApplicationArea = All;
                //     Editable = false;
                // }

                field("Merge Unit ID"; Rec."Merge Unit ID")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Lookup = true; // Enable lookup for Unit ID
                    Enabled = EnableMergeUnit;

                      trigger OnValidate()
                       
                        begin
                            UpdateVisibility();
                        end;

                }


                // label(NoteMergeUnit)
                // {
                //     Caption = 'Note: Once you have selected the Merge unit IDs in the "Lease proposal card" and have approved the Alert Notification in the Proposal form then the mentioned units status will get updated to "Selected", in order to make it FREE you need to manually "Decline" the Proposal and then need to update the Merge Status to "Unmerge" in the respective "Merge unit card". This will make the "Merge unit" entry "Not Applicable" or "N/A" and which cannot be used again.';
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                field("Property Address"; rec."Unit Address")
                {
                    ApplicationArea = All;
                    Editable = false;

                }


                field("Unit Number"; Rec."Unit Number") // Custom Field
                {
                    ApplicationArea = All;
                    Caption = 'Unit Number';
                    Editable = false;

                }

                field("Unit Classification"; rec."Usage Type")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    Editable = false;
                }

                field("Unit Type"; rec."Unit Type")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Unit Name"; Rec."Unit Name") // Custom Field
                {
                    ApplicationArea = All;
                    Caption = 'Unit Name';
                    Editable = false;
                }

                field("Single Unit Name"; Rec."Single Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("Uniq Unit ID"; Rec.UnitID) // Auto-generated Unit ID
                {
                    ApplicationArea = All;
                    Caption = 'Uniq Unit ID';
                    Editable = false;
                }

                field("Base Unit of Measure"; rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    Lookup = true;
                }

                field("Market Rate per Sq. Ft."; rec."Market Rate per Sq. Ft.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Unit Size"; rec."Unit Size")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Facilities/Amenities"; rec."Facilities/Amenities")
                {
                    ApplicationArea = All;
                }
                field("Property Size"; Rec."Property Size")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Makani Number"; Rec."Makani Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Emirate; Rec.Emirate)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Community; Rec.Community)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("DEWA Number"; Rec."DEWA Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("Tenant Details")
            {

                field("Tenant ID"; rec."Tenant ID")
                {
                    ApplicationArea = All;

                }
                field("Tenant Full Name"; rec."Tenant Full Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Tenant Contact Phone"; rec."Tenant Contact Phone")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Tenant Contact Email"; rec."Tenant Contact Email")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Emirates ID"; rec."Emirates ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("License No."; Rec."License No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Licensing Authority"; Rec."Licensing Authority")
                {
                    ApplicationArea = All;
                    Editable = false;
                }


                field("Legal Representative"; rec."Legal Representative")
                {
                    ApplicationArea = All;

                }
            }

            group("Lease Terms")
            {
                field("Lease Start Date"; rec."Lease Start Date")
                {
                    ApplicationArea = All;
                }
                field("Lease End Date"; rec."Lease End Date")
                {
                    ApplicationArea = All;
                }
                field("Lease Duration"; rec."Lease Duration")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rent Amount"; rec."Rent Amount")
                {
                    ApplicationArea = All;
                }
                field("Annual Rent Amount"; rec."Annual Rent Amount")
                {
                    ApplicationArea = All;

                }
                field("Rent VAT Amount"; rec."Rent VAT Amount")
                {
                    ApplicationArea = All;

                }


                field("Rent Amount VAT %"; rec."Rent Amount VAT %")
                {
                    ApplicationArea = All;

                }

                field("Rent Amount Including VAT"; rec."Rent Amount Including VAT")
                {
                    ApplicationArea = All;

                }

                field("Payment Frequency"; rec."Payment Frequency")
                {
                    ApplicationArea = All;
                    Caption = 'Frequency of payment';
                    trigger OnValidate()
                    var
                        NoOfInstallments: Integer;
                    begin
                        case rec."Payment Frequency" of
                            rec."Payment Frequency"::Monthly:
                                NoOfInstallments := 12;
                            rec."Payment Frequency"::Quarterly:
                                NoOfInstallments := 4;
                            rec."Payment Frequency"::"Half-Yearly":
                                NoOfInstallments := 2;
                            rec."Payment Frequency"::Yearly:
                                NoOfInstallments := 1;
                            else
                                NoOfInstallments := 0;
                        end;
                        rec."No of Installments" := NoOfInstallments;
                    end;
                }
                field("No of Installments"; rec."No of Installments")
                {
                    ApplicationArea = All;
                    Caption = 'No of Installments';
                    Visible = false;
                }
                field("Payment Method"; rec."Payment Method")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Mode';
                }
                // field("Grace Period"; rec."Grace Period")
                // {
                //     ApplicationArea = All;
                // }
            }

            group("Deposit and Fees")
            {
                field("Security Deposit Amount"; rec."Security Deposit Amount")
                {
                    ApplicationArea = All;
                }
                field("Other Fees"; rec."Other Fees")
                {
                    ApplicationArea = All;
                }
                field("Refund Conditions"; rec."Refund Conditions")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
               

            }

           

            group("Responsibilities")
            {
                field("Maintenance Responsibilities"; rec."Maintenance Responsibilities")
                {
                    ApplicationArea = All;
                }
                field("Utility Bills Responsibility"; rec."Utility Bills Responsibility")
                {
                    ApplicationArea = All;
                }
                field("Insurance Requirements"; rec."Insurance Requirements")
                {
                    ApplicationArea = All;
                }
            }

            group("Conditions for Renewal")
            {

                field("Rent Escalation Clause"; rec."Rent Escalation Clause")
                {
                    ApplicationArea = All;
                }
            }

            group("Special Conditions")
            {
                field("Early Termination Conditions"; rec."Early Termination Conditions")
                {
                    ApplicationArea = All;
                }
                field("Restrictions"; rec."Restrictions")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Legal Jurisdiction"; rec."Legal Jurisdiction")
                {
                    ApplicationArea = All;
                }

                field("Single Rent Calculation";Rec."Single Rent Calculation")
                {
                    ApplicationArea = All;
                    Editable = Rec."Praposal Type Selected" = Rec."Praposal Type Selected"::"Single Unit";

                    trigger OnValidate()
                    begin
                        UpdateVisibility();
                    end;
                }
                field("Merge Rent Calculation";Rec."Merge Rent Calculation")
                {
                    ApplicationArea = All;
                    Editable = Rec."Praposal Type Selected" = Rec."Praposal Type Selected"::"Merge Unit";

                    trigger OnValidate()
                    begin
                        UpdateVisibility();
                    end;
                }
                field("Proposal Status"; rec."Proposal Status")
                {
                    ApplicationArea = All;
                }

                field("Update Data"; Rec."Update Data")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        SingleUnitName: Text;
                        CommaPos: Integer;
                        TargetRecord: Record "Revenue Structure";
                        LeaseProposal: Record "Lease Proposal Details";
                        SU_samesquare: Record "Single Unit Rent SubPage";
                        SU_lumpsum: Record "Single Lum_AnnualAmnt SubPage";
                        MU_samesquare: Record "Merge SameSqure SubPage";
                        MU_differentsquare: Record "Merge DifferentSqure SubPage";
                        MU_lumpsum: Record "Merge Lum_AnnualAmount SubPage";
                        RevenueSubpage: Record "Revenue Structure Subpage";
                    begin
                        // Find the lease proposal record
                        LeaseProposal.SetRange("Proposal ID", Rec."Proposal ID");
                        if LeaseProposal.FindFirst() then begin
                            // Initialize and insert new record with data from lease proposal
                            TargetRecord.Init();
                           // TargetRecord."Proposal ID" := LeaseProposal."Proposal ID";
                            TargetRecord."Contract Start Date" := LeaseProposal."Lease Start Date";
                            TargetRecord."Contract End Date" := LeaseProposal."Lease End Date";
                            TargetRecord."Amount" := LeaseProposal."Annual Rent Amount";
                            TargetRecord."Tenant ID" := LeaseProposal."Tenant ID";
                            TargetRecord."Secondary Item Type" := 'Rent';
                            TargetRecord."VAT Amount" := LeaseProposal."Rent VAT Amount";
                            TargetRecord."Amount Including VAT" := LeaseProposal."Rent Amount Including VAT";

                            // Handle rent calculation type assignment
                            if LeaseProposal."Single Rent Calculation" = LeaseProposal."Single Rent Calculation"::"Single Unit with lumpsum square feet rate" then
                                TargetRecord."Rent Calculation Type" := Format(LeaseProposal."Single Rent Calculation")
                            else if LeaseProposal."Single Rent Calculation" = LeaseProposal."Single Rent Calculation"::"Single Unit with square feet rate" then
                                TargetRecord."Rent Calculation Type" := Format(LeaseProposal."Single Rent Calculation")
                            else if LeaseProposal."Merge Rent Calculation" = LeaseProposal."Merge Rent Calculation"::"Merged Unit with differential square feet rate" then
                                TargetRecord."Rent Calculation Type" := Format(LeaseProposal."Merge Rent Calculation")
                            else if LeaseProposal."Merge Rent Calculation" = LeaseProposal."Merge Rent Calculation"::"Merged Unit with lumpsum annual amount" then
                                TargetRecord."Rent Calculation Type" := Format(LeaseProposal."Merge Rent Calculation")
                            else if LeaseProposal."Merge Rent Calculation" = LeaseProposal."Merge Rent Calculation"::"Merged Unit with same square feet" then
                                TargetRecord."Rent Calculation Type" := Format(LeaseProposal."Merge Rent Calculation")
                            else
                                Error('No valid Rent Calculation Type found in Lease Proposal.');

                            TargetRecord.Insert();

                            // Update data in Revenue Structure Subpage for Single Rent Calculation
                            if LeaseProposal."Single Rent Calculation" = LeaseProposal."Single Rent Calculation"::"Single Unit with lumpsum square feet rate" then begin
                                SU_lumpsum.SetRange("Proposal ID", LeaseProposal."Proposal ID");
                                if SU_lumpsum.FindSet() then begin
                                    repeat
                                        if not RevenueSubpage.Get(TargetRecord."RS ID", SU_lumpsum.SL_Year) then begin
                                            RevenueSubpage.Init();
                                            RevenueSubpage."RS ID" := TargetRecord."RS ID";
                                            RevenueSubpage.Year := SU_lumpsum.SL_Year;
                                            RevenueSubpage."Period Start Date" := SU_lumpsum."SL_Start Date";
                                            RevenueSubpage."Period End Date" := SU_lumpsum."SL_End Date";
                                            RevenueSubpage."Number of Days" := SU_lumpsum."SL_Number of Days";
                                          
                                            RevenueSubpage.Insert();
                                            Clear(RevenueSubpage);



                                        end else
                                            Message('Skipping duplicate record for RS ID=%1, Year=%2.',
                                                    TargetRecord."RS ID", SU_lumpsum.SL_Year);
                                    until SU_lumpsum.Next() = 0;
                                end else
                                    Error('No data found in Single Unit with lumpsum square feet rate subpage for Proposal ID %1.', LeaseProposal."Proposal ID");
                            end
                            else if LeaseProposal."Single Rent Calculation" = LeaseProposal."Single Rent Calculation"::"Single Unit with square feet rate" then begin
                                SU_samesquare.SetRange("Proposal ID", LeaseProposal."Proposal ID");
                                if SU_samesquare.FindSet() then begin
                                    repeat
                                        if not RevenueSubpage.Get(TargetRecord."RS ID", SU_samesquare.Year) then begin
                                            RevenueSubpage.Init();
                                            RevenueSubpage."RS ID" := TargetRecord."RS ID";
                                            RevenueSubpage.Year := SU_samesquare.Year;
                                            RevenueSubpage."Period Start Date" := SU_samesquare."Start Date";
                                            RevenueSubpage."Period End Date" := SU_samesquare."End Date";
                                            RevenueSubpage."Number of Days" := SU_samesquare."Number of Days";
                                            
                                            RevenueSubpage.Insert();
                                            Clear(RevenueSubpage);
                                        end else
                                            Message('Skipping duplicate record for RS ID=%1, Year=%2.',
                                                    TargetRecord."RS ID", SU_samesquare.Year);
                                    until SU_samesquare.Next() = 0;
                                end else
                                    Error('No data found in Single Unit with square feet rate subpage for Proposal ID %1.', LeaseProposal."Proposal ID");
                            end
                           
                           else if LeaseProposal."Merge Rent Calculation" = LeaseProposal."Merge Rent Calculation"::"Merged Unit with differential square feet rate" then begin
                                // Find the lease proposal record
                                LeaseProposal.SetRange("Proposal ID", Rec."Proposal ID");
                                if LeaseProposal.FindFirst() then begin
                                    // Extract the first unit name by trimming at the first comma
                                    begin
                                        SingleUnitName := LeaseProposal."Single Unit Name";
                                        CommaPos := StrPos(SingleUnitName, ','); // Find the position of the first comma
                                        if CommaPos > 0 then
                                            SingleUnitName := CopyStr(SingleUnitName, 1, CommaPos - 1) // Trim to the first name
                                        else
                                            SingleUnitName := SingleUnitName; // No comma, use the whole name

                                        // Find the first unit's details in Merge DifferentSquare table
                                        MU_differentsquare.SetRange("Proposal ID", LeaseProposal."Proposal ID");
                                        MU_differentsquare.SetRange("MD_Unit ID", SingleUnitName); // Filter by the first unit name
                                        if MU_differentsquare.FindSet() then begin
                                            repeat
                                                // Update Revenue Structure Subpage
                                                if not RevenueSubpage.Get(TargetRecord."RS ID", MU_differentsquare.MD_Year) then begin
                                                    RevenueSubpage.Init();
                                                    RevenueSubpage."RS ID" := TargetRecord."RS ID";
                                                    RevenueSubpage.Year := MU_differentsquare.MD_Year;
                                                    RevenueSubpage."Period Start Date" := MU_differentsquare."MD_Start Date";
                                                    RevenueSubpage."Period End Date" := MU_differentsquare."MD_End Date";
                                                    RevenueSubpage."Number of Days" := MU_differentsquare."MD_Number of Days";
                                                    RevenueSubpage.Insert();
                                                    Clear(RevenueSubpage);
                                                end else
                                                    Message('Skipping duplicate record for RS ID=%1, Year=%2.',
                                                            TargetRecord."RS ID", MU_differentsquare.MD_Year);
                                            until MU_differentsquare.Next() = 0;

                                            // Message('Revenue data successfully updated for Unit Name: %1.', SingleUnitName);
                                        end else
                                            Error('No data found for Unit Name: %1 in Proposal ID: %2.', SingleUnitName, LeaseProposal."Proposal ID");
                                    end;
                                end else
                                    Error('Lease Proposal not found for Proposal ID: %1.', Rec."Proposal ID");
                            end
                        

                            else if LeaseProposal."Merge Rent Calculation" = LeaseProposal."Merge Rent Calculation"::"Merged Unit with lumpsum annual amount" then begin
                                MU_lumpsum.SetRange("Proposal ID", LeaseProposal."Proposal ID");
                                if MU_lumpsum.FindSet() then begin
                                    repeat
                                        if not RevenueSubpage.Get(TargetRecord."RS ID", MU_lumpsum.ML_Year) then begin
                                            RevenueSubpage.Init();
                                            RevenueSubpage."RS ID" := TargetRecord."RS ID";
                                            RevenueSubpage.Year := MU_lumpsum.ML_Year;
                                            RevenueSubpage."Period Start Date" := MU_lumpsum."ML_Start Date";
                                            RevenueSubpage."Period End Date" := MU_lumpsum."ML_End Date";
                                            RevenueSubpage."Number of Days" := MU_lumpsum."ML_Number of Days";
                                            RevenueSubpage.Insert();
                                            Clear(RevenueSubpage);
                                        end else
                                            Message('Skipping duplicate record for RS ID=%1, Year=%2.',
                                                    TargetRecord."RS ID", MU_lumpsum.ML_Year);
                                    until MU_lumpsum.Next() = 0;
                                end else
                                    Error('No data found in Merged Unit with lumpsum annual amount subpage for Proposal ID %1.', LeaseProposal."Proposal ID");
                            end
                            else if LeaseProposal."Merge Rent Calculation" = LeaseProposal."Merge Rent Calculation"::"Merged Unit with same square feet" then begin
                                MU_samesquare.SetRange("Proposal ID", LeaseProposal."Proposal ID");
                                if MU_samesquare.FindSet() then begin
                                    repeat
                                        if not RevenueSubpage.Get(TargetRecord."RS ID", MU_samesquare.MS_Year) then begin
                                            RevenueSubpage.Init();
                                            RevenueSubpage."RS ID" := TargetRecord."RS ID";
                                            RevenueSubpage.Year := MU_samesquare.MS_Year;
                                            RevenueSubpage."Period Start Date" := MU_samesquare."MS_Start Date";
                                            RevenueSubpage."Period End Date" := MU_samesquare."MS_End Date";
                                           
                                            RevenueSubpage."Number of Days" := MU_samesquare."MS_Number of Days";
                                            RevenueSubpage.Insert();
                                            Clear(RevenueSubpage);
                                        end else
                                            Message('Skipping duplicate record for RS ID=%1, Year=%2.',
                                                    TargetRecord."RS ID", MU_samesquare.MS_Year);
                                    until MU_samesquare.Next() = 0;
                                end else
                                    Error('No data found in Merged Unit with same square feet subpage for Proposal ID %1.', LeaseProposal."Proposal ID");
                            end;

                            Message('New record has been created in Revenue Structure and subpage updated successfully.');
                        end else
                            Error('Lease Proposal not found for Proposal ID %1.', Rec."Proposal ID");
                    end;
                }

            }

            
        


            group("Single Unit with lumpsum square feet rate")
            {
                Caption = 'Single Unit with lumpsum square feet rate';
                Visible = ShowLegalReasonFields3;

                part("Single Unit lumpsum Rent"; "Single Lum_AnnualAmnt SubPage")
                {
                    SubPageLink = "Proposal ID" = FIELD("Proposal ID"); // Link to filter attachments for this owner only
                    ApplicationArea = All;
                    // Visible = isVisible;
                }
            }

            group("Single Unit with square feet rate")
            {
                Caption = 'Single Unit With Square Feet Rate';
                Visible = ShowLegalReasonFields;

                part("Single Unit Rent"; "Single Unit Rent SubPage")
                {
                    SubPageLink = "Proposal ID" = FIELD("Proposal ID"); // Link to filter attachments for this owner only
                    ApplicationArea = All;
                    // Visible = isVisible;
                }

            }
            group("Merged Unit with same square feet")
            {
                Caption = 'Merged Unit With Same Square Feet';
                Visible = ShowBusinessReasonFields;
                part("Merge SameSqure Rent"; "Merge SameSqure SubPage")
                {
                    SubPageLink = "Proposal ID" = FIELD("Proposal ID"); // Link to filter attachments for this owner only
                    ApplicationArea = All;
                    // Visible = isVisible;
                }
            }
            group("Merged Unit with differential square feet rate")
            {
                Caption = 'Merged Unit With Differential Square Feet Rate';
                Visible = ShowLegalReasonFields1;
                part("Merge DifferentSqure Rent"; "Merge DifferentSqure SubPage")
                {
                    SubPageLink = "Proposal ID" = FIELD("Proposal ID"); // Link to filter attachments for this owner only
                    ApplicationArea = All;
                    // Visible = isVisible;
                }
            }
            group("Merged Unit with lumpsum annual amount")
            {
                Caption = 'Merged Unit With Lumpsum Annual Amount';
                Visible = ShowBusinessReasonFields2;
                part("Merge Lum_AnnualAmount Rent"; "Merge Lum_AnnualAmount SubPage")
                {
                    SubPageLink = "Proposal ID" = FIELD("Proposal ID"); // Link to filter attachments for this owner only
                    ApplicationArea = All;
                    // Visible = isVisible;
                }
            }

            group("Per Day Rent for Revenue Allocation")
            {
                Caption = 'Per Day Rent for Revenue Allocation';
                part("Per Day Rent for Revenue"; "Per Day Rent for Revenue Card")
                {
                    SubPageLink = "Proposal Id" = FIELD("Proposal ID"); // Link to filter attachments for this owner only
                    ApplicationArea = All;
                    Visible = Rec."Praposal Type Selected" = Rec."Praposal Type Selected"::"Merge Unit"; // Visible when "Praposal Type Selected" is "Merge Unit"
                }
            }

            group("Lease Unit Details")
            {
                Caption = 'Unit Details';
                part("Unit all Details"; "Sub Lease Merged Units Card")
                {
                    SubPageLink = "Merge Unit ID" = FIELD("Merge Unit ID"); // Link to filter attachments for this owner only
                    ApplicationArea = All;
                    Visible = Rec."Praposal Type Selected" = Rec."Praposal Type Selected"::"Merge Unit"; // Visible when "Praposal Type Selected" is "Merge Unit"
                }
            }



        

            group("Other Payments")
            {
                part("Revenue"; "Revenue Item SubPage Card")
                {
                    SubPageLink = ProposalID = FIELD("Proposal ID"); // Link to filter attachments for this owner only
                    ApplicationArea = All;
                    // Visible = isVisible;
                }
            }

            // group("One Time Pay")
            // {
            //     part("Revenue2"; "Revenue Item SubPage Card2")
            //     {
            //         SubPageLink = ProposalID = FIELD("Proposal ID"); // Link to filter attachments for this owner only
            //         ApplicationArea = All;
            //         // Visible = isVisible;
            //     }
            // }
        }
    }



    actions
    {
        area(processing)
        {


            action("Save")
            {
                Caption = 'Save';
                ApplicationArea = All;
                Image = Save;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.Modify(true);
                end;
            }

            // action("Delete")
            // {
            //     Caption = 'Delete';
            //     ApplicationArea = All;
            //     Image = Delete;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     trigger OnAction()
            //     begin
            //         if Confirm('Are you sure you want to delete this record?') then
            //             Rec.Delete(true);
            //     end;
            // }


        }
        area(Reporting)
        {
            group(Report)
            {
                Caption = 'Report';
                action("Run Report")
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        LeasePrposal: Record "Lease Proposal Details";
                        ReportRequest: Report "Proposal Report";
                    begin
                        Commit();

                        LeasePrposal.SetRange("Proposal ID", Rec."Proposal ID");

                        ReportRequest.SetTableView(LeasePrposal);
                        ReportRequest.Run();
                    end;
                }
            }
        }
    }



    var
        EnableSingleUnit: Boolean;
        EnableMergeUnit: Boolean;

    // Update the enable logic based on "Proposal Type Selected"
    trigger OnAfterGetRecord()
    begin
        // EnableSingleUnit := true;
        // UpdateUnitEnableState();
        CurrPage."Revenue".Page.SetProposalId(Rec."Proposal ID");
        CurrPage."Revenue".Page.SetStartEndDate(Rec."Lease Start Date", Rec."Lease End Date");
        CurrPage."Revenue".Page.SetTenantID(Rec."Tenant ID");

        // CurrPage."Revenue2".Page.SetProposalId(Rec."Proposal ID");
        // CurrPage."Revenue2".Page.SetStartEndDate(Rec."Lease Start Date", Rec."Lease End Date");

        CurrPage."Single Unit Rent".Page.Update();
        CurrPage."Merge SameSqure Rent".Page.Update();
        // CurrPage."Merge DifferentSqure Rent".Page.Update();
        CurrPage."Merge Lum_AnnualAmount Rent".Page.Update();
        CurrPage."Single Unit lumpsum Rent".Page.Update();
        // CurrPage."Unit all Details".Page.Update();


        // CalculateTotals();
    end;

    // Function to update enabled state of Unit fields
    local procedure UpdateUnitEnableState()
    begin
        case Rec."Praposal Type Selected" of
            Rec."Praposal Type Selected"::"Single Unit":
                begin
                    EnableSingleUnit := true;
                    EnableMergeUnit := false;
                end;
            Rec."Praposal Type Selected"::"Merge Unit":
                begin
                    EnableSingleUnit := false;
                    EnableMergeUnit := true;
                end;
            else
                EnableSingleUnit := false; // Keep Single Unit enabled by default
                EnableMergeUnit := false;
        end;
        CurrPage.Update(); // Refresh the page to apply changes
    end;

    var
        isVisible: Boolean;


    trigger OnModifyRecord(): Boolean
    begin
        CurrPage."Revenue".Page.SetProposalId(Rec."Proposal ID");
        CurrPage."Revenue".Page.SetStartEndDate(Rec."Lease Start Date", Rec."Lease End Date");
        CurrPage."Revenue".Page.SetTenantID(Rec."Tenant ID");

        // CurrPage."Revenue2".Page.SetProposalId(Rec."Proposal ID");
        // CurrPage."Revenue2".Page.SetStartEndDate(Rec."Lease Start Date", Rec."Lease End Date");

        // CalculateTotals();


    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage."Revenue".Page.SetProposalId(Rec."Proposal ID");
        CurrPage."Revenue".Page.SetStartEndDate(Rec."Lease Start Date", Rec."Lease End Date");
        CurrPage."Revenue".Page.SetTenantID(Rec."Tenant ID");

        // CurrPage."Revenue2".Page.SetProposalId(Rec."Proposal ID");
        // CurrPage."Revenue2".Page.SetStartEndDate(Rec."Lease Start Date", Rec."Lease End Date");
        // CalculateTotals();
    end;



    var
        ShowLegalReasonFields: Boolean;
        ShowBusinessReasonFields: Boolean;

        ShowLegalReasonFields1: Boolean;
        ShowBusinessReasonFields2: Boolean;
        ShowLegalReasonFields3: Boolean;

        ShowLegalReasonFields4:Boolean;

        ShowLegalReasonFields5: Boolean;

    trigger OnOpenPage()
    begin
        UpdateVisibility();
        // SetRange("Merge Unit ID", Rec."Merge Unit ID");
    end;

    // Procedure to update visibility dynamically
    procedure UpdateVisibility()
    begin
        ShowLegalReasonFields := (Rec."Single Rent Calculation" = Rec."Single Rent Calculation"::"Single Unit with square feet rate");
        ShowBusinessReasonFields := (Rec."Merge Rent Calculation" = Rec."Merge Rent Calculation"::"Merged Unit with same square feet");
        ShowLegalReasonFields1 := (Rec."Merge Rent Calculation" = Rec."Merge Rent Calculation"::"Merged Unit with differential square feet rate");
        ShowBusinessReasonFields2 := (Rec."Merge Rent Calculation" = Rec."Merge Rent Calculation"::"Merged Unit with lumpsum annual amount");
        ShowLegalReasonFields3 := (Rec."Single Rent Calculation" = Rec."Single Rent Calculation"::"Single Unit with lumpsum square feet rate");
        ShowLegalReasonFields4 := (Rec."Praposal Type Selected" = Rec."Praposal Type Selected":: "Merge Unit");
    end;

    var
        TotalFinalAmount: Decimal;
        TotalAnnualAmount: Decimal;
        TotalRoundOff: Decimal;

    // Procedure to calculate totals


    // local procedure CalculateTotals()
    // var
    //     SingleUnitRentRec: Record "Single Unit Rent SubPage"; // Ensure this matches the actual subpage table name
    // begin
    //     // Initialize totals to zero
    //     TotalFinalAmount := 0;
    //     TotalAnnualAmount := 0;
    //     TotalRoundOff := 0;

    //     // Filter records by Proposal ID
    //     SingleUnitRentRec.SetRange("Proposal ID", Rec."Proposal ID");

    //     // Calculate totals for filtered records
    //     if SingleUnitRentRec.FindSet() then
    //         repeat
    //             TotalFinalAmount += SingleUnitRentRec."Final Annual Amount"; // Replace with correct field names
    //             TotalAnnualAmount += SingleUnitRentRec."Annual Amount";
    //             TotalRoundOff += SingleUnitRentRec."Round Off";
    //         until SingleUnitRentRec.Next() = 0;

    //     // Update the current record fields
    //     Rec.TotalFinalAmount := TotalFinalAmount;
    //     Rec.TotalAnnualAmount := TotalAnnualAmount;
    //     Rec.TotalRoundOff := TotalRoundOff;

    //     // Save changes
    //     Rec.Modify(false);
    // end;

   


}


 
