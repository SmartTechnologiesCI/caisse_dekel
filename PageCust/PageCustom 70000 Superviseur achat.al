// profile "Superviseur achat"
// {
//     Description = 'Agent de pesée';
//     Caption = 'Superviseur achat';
//     // RoleCenter = "Achat RoleCenter";
//     Customizations = "Achat activity pageCust", "Achat rolecenter pagecust";

// }
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


