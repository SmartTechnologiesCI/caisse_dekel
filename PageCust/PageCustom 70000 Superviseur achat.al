profile "Superviseur achat"
{
    Description = 'Agent de pesée';
    Caption = 'Superviseur achat';
    RoleCenter = "Achat RoleCenter";
    Customizations = "Achat activity pageCust", "Achat rolecenter pagecust";

}
profile "Superviseur Achat/Stock"
{

    Caption = 'Superviseur Achat & Stock';
    RoleCenter = "Achat RoleCenter";
    Customizations = "Achat activity pageCust", "Achat & Stock", "Def Prix Article";

}



pagecustomization "Achat activity pageCust" customizes 50017
{
    layout
    {
        // Add changes to page layout here

        modify("Factures douanieres")
        {
            Visible = true;

        }
        modify("Contrats Non payés")
        {

            Visible = true;
        }
        modify("Contrats payés")
        {

            Visible = true;
        }
        modify("Contrats partiellement payés")
        {

            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    //Variables, procedures and triggers are not allowed on Page Customizations
}
pagecustomization "Achat activity pageCust2" customizes 50017
{
    layout
    {
        // Add changes to page layout here

        modify("Factures douanieres")
        {
            Visible = true;

        }
        modify("Contrats Non payés")
        {

            Visible = false;
        }
        modify("Contrats payés")
        {

            Visible = false;
        }
        modify("Contrats partiellement payés")
        {

            Visible = false;
        }
        modify("Conteneurs Embarqués")
        {
            Visible = false;
        }
        modify("Conteneurs en Chargement")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    //Variables, procedures and triggers are not allowed on Page Customizations
}
pagecustomization "Achat rolecenter pagecust" customizes 50016
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here 
        modify("Historique Facture douaniere")
        {
            Visible = true;
        }
        modify("Etat des Contrats fournisseur")
        {
            Visible = true;

        }

    }

    //Variables, procedures and triggers are not allowed on Page Customizations
}


pagecustomization "Achat & Stock" customizes 50016
{
    //Profil pour monsieur roger
    actions
    {
        modify("Ajustement du stock")
        {
            Visible = true;
        }
        modify("Historique Facture douaniere")
        {
            Visible = true;
        }
        modify("Etat des Contrats fournisseur")
        {
            Visible = true;

        }

        modify(AvoirsAchat)
        {
            Visible = false;

        }
        modify(RetoursAchat)
        {
            Visible = false;

        }
        modify(CommandesVente)
        {
            Visible = true;
        }
        modify(PrixaFixer)
        {
            Visible = true;
        }


    }

    //Variables, procedures and triggers are not allowed on Page Customizations
}

pagecustomization "Def Prix Article" customizes 50021
{
    layout
    {
        modify("Coût du contrat")
        {
            Visible = false;
        }
        modify(Charges)
        {
            Visible = false;
        }
        modify("Bénéfices - Marges")
        {
            Visible = false;
        }
    }


    actions
    {
        // Add changes to page actions here
    }

    //Variables, procedures and triggers are not allowed on Page Customizations
}


