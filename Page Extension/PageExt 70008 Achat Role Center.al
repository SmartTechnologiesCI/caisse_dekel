pageextension 70008 "Achat role center Ext" extends 50016
{
    layout
    {

    }

    actions
    {
        // Add changes to page actions here
        addbefore(CommandesAchat)
        {

            action(CommandesVente)
            {
                CaptionML = FRA = 'Commandes Ventes';
                ApplicationArea = All;
                RunObject = page "Sales order List";
                Visible = false;
            }
        }
        addafter(CommandesAchat)
        {

            action("PrixaFixer")
            {
                CaptionML = FRA = 'Prix à appliquer', ENU = 'Prix à appliquer';
                RunObject = Page 70040;
                Visible = false;
            }
        }


        addfirst(Processing)
        {


            action("Depot en attente")
            {
                Caption = 'Dépôt à approuver';
                // Visible = false;
                RunObject = page 70097;

            }

        }
        addlast(Processing)
        {



            action("Historique Facture douaniere")
            {
                Visible = false;
                RunObject = page 70075;
            }

            action("Etat des Contrats fournisseur")
            {
                Visible = false;
                RunObject = Report 70012;
            }

            action("Ajustement du stock")
            {
                Visible = false;
                RunObject = Page 70067;
            }



        }
        addbefore(CommandesVente)
        {
            action("Depotenattente")
            {
                Caption = 'Dépôt à approuver';
                // Visible = false;
                RunObject = page 70097;

            }
        }


    }

    var
        myInt: Integer;
}