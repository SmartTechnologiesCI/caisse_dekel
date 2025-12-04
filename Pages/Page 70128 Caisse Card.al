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
                    Editable = false;
                }
                field("Nom caisse"; "Nom caisse")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Solde; Solde)
                {
                    ApplicationArea = All;
                    Editable = false;
                }


            }
        }
      
    }


    actions
    {
        area(Processing)
        {
            
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        // SetFilter(Utilissateir, '');
    end;
}