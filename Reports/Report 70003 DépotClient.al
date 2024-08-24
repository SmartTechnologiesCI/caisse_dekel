report 70003 "Dépots client"
{

    RDLCLayout = 'Reports\RDLC\Report 70003 Depot.rdlc';
    Caption = 'Listes des articles vendu du jour';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {

        dataitem(Dépôts; Depôt)
        {
            RequestFilterFields = "N°";
            column(N__client; "N° client")
            {

            }
            column(Nom_du_client; "Nom du client")
            {

            }
            column(N_; "N°")
            {

            }
            column(Date; Date)
            {

            }
            column(Heure; Heure)
            {

            }
            column(Code_Caisse; "Code Caisse")
            {

            }
            column(Mode_de_paiement; "Mode de paiement")
            {

            }
            column(Montant; Montant)
            {

            }
            column(Motif; Motif)
            {

            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("N° client");
                column(Total; "Dépôts")
                {

                }
            }
        }
    }

    requestpage
    {
    }
}