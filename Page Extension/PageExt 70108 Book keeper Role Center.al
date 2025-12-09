pageextension 70108 "Book keeper Role Center" extends "Book keeper Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Gestion PI")
        {

            group(Caisse)
            {
                action(point)
                {
                    Caption = 'Point de caisse';
                    RunObject = page PointCaisses;
                    ApplicationArea = All;
                }
                action(TransfertFond)
                {
                    Caption = 'Transférer des fonds';
                    ApplicationArea = All;
                    RunObject = page ListTransfert;
                }

            }
            group(HistoriqueCaisse)
            {
                Caption = 'Historique caisse';
                action(HistoTranstfert)
                {
                    Caption = 'Transfert Fonds';
                    ApplicationArea = ALL;
                    RunObject = page ListTransfertvalide;

                }
                action(Transactions)
                {
                    ApplicationArea = All;
                    Caption = 'Transactions';
                    RunObject = page "Liste des transactions";
                }
            }

        }
    }

    var
        myInt: Integer;
}