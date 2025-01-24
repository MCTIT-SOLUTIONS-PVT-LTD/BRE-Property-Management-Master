table 50929 "Revenue Recognition"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(50102; "RR Id"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'RR Id';

        }

        field(50100; "Proposal ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Lease Proposal Details"."Proposal ID";

            trigger OnValidate()
            var
                leaserec: Record "Lease Proposal Details";
            begin
                leaserec.SetRange("Proposal ID", Rec."Proposal ID");
                if leaserec.FindFirst() then begin
                    "Tenant Id" := leaserec."Tenant Id";
                    "Start Date" := leaserec."Lease Start Date";
                    "End Date" := leaserec."Lease End Date";
                    "Contract Amount" := leaserec."Annual Rent Amount";

                end else begin
                    // Clear the field if no record is found
                    "Tenant Id" := '';
                    "Start Date" := 0D;
                    "End Date" := 0D;
                    "Contract Amount" := 0;
                end;

                CalculateMonthlyRevenue();

            end;
        }
        field(50101; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Id';
            TableRelation = "Lease Proposal Details"."Tenant ID";
            Editable = false; // Make it read-only for the user

        }


        field(50103; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';

        }



        field(50104; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';

        }



        field(50105; "Contract Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount';

        }




    }

    keys
    {
        key(PK; "RR ID")
        {
            Clustered = true;
        }




    }


    //-----------------Calculate Monthly Revenue-----------------//

    local procedure CalculateMonthlyRevenue()
    var
        SubpageRec: Record "Revenue Recognition Subpage";
        StartDate: Date;
        EndDate: Date;
        TotalDays: Integer;
        CurrentDate: Date;
        MonthDays: Integer;
        DailyRate: Decimal;
        MonthlyRate: Decimal;
        AllocatedAmount: Decimal;
        FirstDayNextMonth: Date;
        LastDayOfMonth: Date;
        DaysInMonth: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        IsLeap: Boolean;
        MonthlyRate2: Decimal;
        TotalMonths: Integer;
        ActualDaysInMonth: Integer;
    begin
        // Clear existing records in the subpage table
        SubpageRec.DeleteAll();

        // Ensure Start and End Dates are valid
        if ("Start Date" = 0D) or ("End Date" = 0D) then
            exit;

        TotalMonths := CalculateTotalMonths("Start Date", "End Date");

        TotalDays := ("End Date" - "Start Date") + 1;
        DailyRate := "Contract Amount" / TotalDays;
        //  MonthlyRate := ("Annual Rent Amount" / 12);

        CurrentDate := "Start Date";
        while CurrentDate <= "End Date" do begin
            SubpageRec.Init();
            SubpageRec."RR Id" := "RR Id";
            SubpageRec."Proposal ID" := "Proposal ID";
            SubpageRec."Tenant Id" := "Tenant Id";

            // Format Month-Year
            SubpageRec."Month" := FORMAT(CurrentDate, 0, '<Month Text>') + '-' + FORMAT(CurrentDate, 0, '<Year>');

            // Date2DMY(CurrentDate, Year, Month, Day);

            // Calculate the first day of the next month
            if DATE2DMY(CurrentDate, 2) = 12 then begin
                FirstDayNextMonth := DMY2DATE(1, 1, DATE2DMY(CurrentDate, 3) + 1); // January of next year
            end else begin
                FirstDayNextMonth := DMY2DATE(1, DATE2DMY(CurrentDate, 2) + 1, DATE2DMY(CurrentDate, 3)); // Next month of the same year
            end;

            // // Check for the first day of the next month
            // if Month = 12 then begin
            //     FirstDayNextMonth := DMY2DATE(1, 1, Year + 1); // January of next year
            // end else begin
            //     FirstDayNextMonth := DMY2DATE(1, Month + 1, Year); // Next month of the same year
            // end;


            // Calculate the last day of the current month
            LastDayOfMonth := FirstDayNextMonth - 1;

            // Calculate number of days in the current month
            if "End Date" < LastDayOfMonth then
                MonthDays := "End Date" - CurrentDate + 1
            else
                MonthDays := LastDayOfMonth - CurrentDate + 1;

            // Adjust for Start Date or End Date in partial months
            if CurrentDate = "Start Date" then
                if MonthDays > ("End Date" - CurrentDate + 1) then
                    MonthDays := ("End Date" - CurrentDate + 1);


            IsLeap := IsLeapYear(Year);

            if Month = 2 then begin
                // February handling: 28 days in common year, 29 days in leap year
                if IsLeap then
                    DaysInMonth := 29
                else
                    DaysInMonth := 28;
            end else if (Month = 4) or (Month = 6) or (Month = 9) or (Month = 11) then begin
                // April, June, September, November have 30 days
                DaysInMonth := 30;
            end else begin
                // All other months (January, March, May, July, August, October, December) have 31 days
                DaysInMonth := 31;
            end;

            ActualDaysInMonth := GetDaysInMonthss(CurrentDate);


            // // Check if the days in the month are fewer than the typical month days (30 or 31)
            if MonthDays < ActualDaysInMonth then begin
                // Adjust the MonthlyRate based on actual MonthDays
                MonthlyRate2 := ("Contract Amount" / TotalMonths);
                MonthlyRate := MonthlyRate2 / DaysInMonth * MonthDays;
            end else begin
                // Default case: use the standard MonthlyRate formula
                MonthlyRate := MonthlyRate2;
                //MonthlyRate2 := ("Contract Amount" / TotalMonths);
            end;
            // // ActualDaysInMonth := CALCDATE('<+CM>', CurrentDate) - CALCDATE('<-CM>', CurrentDate);
            // MonthlyRate2 := ("Contract Amount" / TotalMonths);





            AllocatedAmount := MonthDays * DailyRate;

            SubpageRec."No. of Days" := MonthDays;
            SubpageRec."RR - Method 1 (Day)" := AllocatedAmount;
            SubpageRec."RR - Method 2 (Month)" := MonthlyRate;
            SubpageRec.Insert();

            // Move to the first day of the next month
            CurrentDate := FirstDayNextMonth;
        end;
    end;
    //-----------------Calculate Monthly Revenue-----------------//

    //-----------------Calculate Leap year-----------------//


    local procedure IsLeapYear(Year: Integer): Boolean
    begin
        if (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0)) then
            exit(true);
        exit(false);
    end;

    //-----------------Calculate Leap year-----------------//


    // local procedure CalculateTotalMonths(StartDate: Date; EndDate: Date) Result: Integer
    // var
    //     StartYear, StartMonth, EndYear, EndMonth : Integer;
    // begin
    //     // Extract the year and month from the start and end dates
    //     StartYear := DATE2DMY(StartDate, 3); // Year
    //     StartMonth := DATE2DMY(StartDate, 2); // Month
    //     EndYear := DATE2DMY(EndDate, 3); // Year
    //     EndMonth := DATE2DMY(EndDate, 2); // Month

    //     // Calculate the difference in months
    //     Result := ((EndYear - StartYear) * 12) + (EndMonth - StartMonth);

    //     // Adjust if the end date is before the start date in the same month
    //     if EndDate < StartDate then
    //         Result := Result - 1;
    // end;


    //-----------------Calculate Total Months-----------------//

    local procedure CalculateTotalMonths(StartDate: Date; EndDate: Date) Result: Integer
    var
        StartYear, StartMonth, StartDay : Integer;
        EndYear, EndMonth, EndDay : Integer;
        DaysInEndMonth: Integer;
        FirstDayOfNextMonth: Date;
    begin
        // Extract the year, month, and day from the start and end dates
        StartYear := DATE2DMY(StartDate, 3); // Year
        StartMonth := DATE2DMY(StartDate, 2); // Month
        StartDay := DATE2DMY(StartDate, 1); // Day

        EndYear := DATE2DMY(EndDate, 3); // Year
        EndMonth := DATE2DMY(EndDate, 2); // Month
        EndDay := DATE2DMY(EndDate, 1); // Day

        // Calculate the difference in months
        Result := ((EndYear - StartYear) * 12) + (EndMonth - StartMonth);

        // Calculate the number of days in the end month
        if EndMonth = 12 then
            FirstDayOfNextMonth := DMY2DATE(1, 1, EndYear + 1) // January of the next year
        else
            FirstDayOfNextMonth := DMY2DATE(1, EndMonth + 1, EndYear); // First day of the next month

        DaysInEndMonth := FirstDayOfNextMonth - DMY2DATE(1, EndMonth, EndYear);

        // Check if EndDate includes the full final month
        // DaysInEndMonth := CALCDATE('<CM+1>', DMY2DATE(1, EndMonth, EndYear)) - DMY2DATE(1, EndMonth, EndYear);
        if EndDay = DaysInEndMonth then
            Result := Result + 1;
    end;

    //-----------------Calculate Total Months-----------------//





    //-----------------Calculate Total Days in Months-----------------//
    local procedure GetDaysInMonth(CurrentDate: Date): Integer
    var
        FirstDayNextMonth: Date;
        FirstDayCurrentMonth: Date;
    begin
        // Calculate the first day of the next month
        FirstDayNextMonth := CALCDATE('<+CM>', CurrentDate);

        // Calculate the first day of the current month
        FirstDayCurrentMonth := CALCDATE('<-CM>', CurrentDate);

        // Return the difference between the first day of the next month and current month
        exit(FirstDayNextMonth - FirstDayCurrentMonth);
    end;
    //-----------------Calculate Total Days in Months-----------------//

    //-----------------Calculate Total Days in Months's-----------------//


    local procedure GetDaysInMonthss(CurrentDate: Date): Integer
    var
        Year: Integer;
        Month: Integer;
        IsLeap: Boolean;
    begin
        Year := DATE2DMY(CurrentDate, 3); // Extract Year from CurrentDate
        Month := DATE2DMY(CurrentDate, 2); // Extract Month from CurrentDate
        IsLeap := IsLeapYear(Year);

        case Month of
            1, 3, 5, 7, 8, 10, 12: // 31-day months
                exit(31);
            4, 6, 9, 11: // 30-day months
                exit(30);
            2: // February
                if IsLeap then
                    exit(29) // Leap year February has 29 days
                else
                    exit(28); // Non-leap year February has 28 days
        end;
    end;

    //-----------------Calculate Total Days in Months's-----------------//


    // local procedure CalculateMonthlyRevenue()
    // var
    //     SubpageRec: Record "Revenue Recognition Subpage";
    //     StartDate: Date;
    //     EndDate: Date;
    //     TotalDays: Integer;
    //     CurrentDate: Date;
    //     MonthDays: Integer;
    //     MonthlyAmount1: Decimal;
    //     MonthlyAmount2: Decimal;
    //     DailyRate: Decimal;
    //     MonthlyRate: Decimal;
    //     AllocatedAmount: Decimal;
    // begin
    //     // Clear existing records in the subpage table
    //     SubpageRec.DeleteAll();

    //     // Ensure Start and End Dates are valid
    //     if ("Start Date" = 0D) or ("End Date" = 0D) then
    //         exit;

    //     TotalDays := ("End Date" - "Start Date") + 1;
    //     DailyRate := "Annual Rent Amount" / TotalDays;
    //     MonthlyRate := "Annual Rent Amount" / 12;

    //     CurrentDate := "Start Date";
    //     while CurrentDate <= "End Date" do begin
    //         SubpageRec.Init();
    //         SubpageRec."RR Id" := "RR Id";
    //         SubpageRec."Proposal ID" := "Proposal ID";
    //         SubpageRec."Tenant Id" := "Tenant Id";
    //         SubpageRec."Month" := FORMAT(CurrentDate, 0, '<Month Text>') + '-' + FORMAT(CurrentDate, 0, '<Year>');
    //         MonthDays := CALCDATE('<+1M>', CurrentDate) - CurrentDate;

    //         if (CurrentDate + MonthDays - 1) > "End Date" then
    //             MonthDays := ("End Date" - CurrentDate) + 1;

    //         AllocatedAmount := MonthDays * DailyRate;

    //         SubpageRec."No. of Days" := MonthDays;
    //         SubpageRec."RR - Method 1 (Day)" := AllocatedAmount;
    //         SubpageRec."RR - Method 2 (Month)" := MonthlyRate;
    //         SubpageRec.Insert();

    //         CurrentDate := CALCDATE('<+1M>', CurrentDate);
    //     end;
    // end;



}