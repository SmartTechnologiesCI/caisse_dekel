page 70128 Caisse_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    SourceTable = Caisse;

    layout
    {
        area(Content)
        {
            group(Général)
            {
                field("Code caisse"; "Code caisse")
                {
                    ApplicationArea = All;
                }
                field("Nom caisse"; "Nom caisse")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field(Solde; Solde)
                {
                    ApplicationArea = All;
                }


            }
        }
        area(Factboxes)
        {

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
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        // SetFilter(Utilissateir, '');
    end;
}