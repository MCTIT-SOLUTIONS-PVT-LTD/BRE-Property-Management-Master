page 50517 "Payment Series Grid"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Payment Series Details";
    Caption = 'Payment Series Grid';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("payment Series"; Rec."payment Series")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ApplicationArea = All;
                }
                field("Cheque Number"; Rec."Cheque Number")
                {
                    ApplicationArea = All;

                }
                field("Deposite Bank"; Rec."Deposite Bank")
                {
                    ApplicationArea = All;
                }
                field("Deposite Status"; Rec."Deposite Status")
                {
                    ApplicationArea = All;
                }
                field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = All;
                }
                field("Cheque Status"; Rec."Cheque Status")
                {
                    ApplicationArea = All;
                }
                field("Old Cheque"; Rec."Old Cheque")
                {
                    ApplicationArea = All;
                }
                field(View; Rec.View)
                {
                    ApplicationArea = All;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                }
                field("Payment Transaction Id"; Rec."Payment Transaction Id")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}