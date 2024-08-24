profile facturierC
{
    Description = 'facturier';
    RoleCenter = "Facturier role center";
    Customizations = MyCustomization, facturierCustum;
    Caption = 'facturier';
}

pagecustomization MyCustomization customizes "Ligne commande paiement"
{
    layout
    {
        modify("Montant HT")
        {
            Visible = true;
        }
        modify("Prix unitaire HT")
        {
            Visible = true;
        }
        modify("Line Amount")
        {
            Visible = false;
        }
        modify("Unit Price")
        {
            Visible = false;
        }
    }

}

pagecustomization facturierCustum customizes "facturier Entête"
{
    layout
    {
        modify(Paiement)
        {
            Visible = false;
        }
    }

    actions
    {
        modify("Facturier")
        {
            Visible = true;
        }
        modify("Afficher Totaux"){
            Visible=true;
        }
  

    }

    //Variables, procedures and triggers are not allowed on Page Customizations
}