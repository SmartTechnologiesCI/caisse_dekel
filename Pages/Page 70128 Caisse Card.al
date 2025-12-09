page 70128 CaisseCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Caisse;
    InsertAllowed = true;
    ModifyAllowed = true;
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
                field(Solde; rec.Solde)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        Transaction: Record Transactions;
                    begin
                        Transaction.SetFilter("Code caisse", reC."Code caisse");
                        if Transaction.FindSet() then begin
                            page.Run(page::"Liste des transactions", Transaction);
                        end;
                    end;
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

    var
        myInt: Integer;
}