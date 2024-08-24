profile "Responsable Daf"
{
    Description = 'DAF';
    CaptionML = ENU = 'Financial director', FRA = 'Responsable Adminitratif et financier';
    RoleCenter = "ResponsableDaf RC";
    //Customizations = SalesLinesCustomizations;
}
page 70094 "ResponsableDaf RC"
{
    PageType = RoleCenter;
    SourceTable = "Director Cue";
    layout
    {
        area(RoleCenter)
        {

            part("Compte tiers activity"; "Compte tiers activity")
            {
                ApplicationArea = All;
            }
            part("Headline"; 70052)
            {


            }

            part("La Tulipe Food"; 70093)
            {
                ApplicationArea = All;
            }

            part(inbox; "Report Inbox Part")
            {

            }



        }

    }

    actions
    {
        area(Creation)
        {

        }
        area(Reporting)
        {
            action("&Etat liste des fournisseurs")
            {
                Caption = 'fournisseurs à payer';
                RunObject = report 70012;
            }
            action("Etat douaniers")
            {
                Caption = 'Etat des échantillons douaniers';
                RunObject = report 70017;
            }
        }
        area(Sections)
        {



            group("Historique")
            {
                action("Facture achat enregistrées")
                {
                    Visible = false;
                    RunObject = Page 146;
                }
                action("Facture ventes enregistrées")
                {
                    RunObject = Page 143;
                }
                action("Transactions journalières")
                {
                    RunObject = Page 70002;
                }
                action("Historique des dépôts")
                {
                    RunObject = Page 70062;
                }
                action("Historique des entrées et sorties")
                {
                    RunObject = Page 70063;
                }

                action("Historique des encaissements")
                {
                    RunObject = Page 70037;
                }
                action("Facture douaniere")
                {
                    RunObject = page 70075;
                }
                action("Factures annulées")
                {
                    RunObject = page 70076;
                }
            }
            group(Clients)
            {
                action("Liste des Clients")
                {
                    RunObject = Page "Customer List";
                }
                action("Liste des Clients à crédit autorisé")
                {
                    RunObject = Page 70053;
                }
                action("Liste des Clients à crédits actifs")
                {
                    RunObject = Page 70061;
                }
            }
            group(Etats)
            {


                group(statistiques)
                {
                    action("Articles vendu")
                    {
                        Caption = 'Articles vendus';
                        RunObject = report 70002;
                    }


                }
                group(Listes)
                {
                    action("Etat liste des fournisseurs")
                    {
                        Caption = 'Fournisseurs à payer';
                        RunObject = report 70012;
                    }
                    action("Etat Conteneur vendu")
                    {
                        RunObject = report 70013;
                    }
                    action("Etat Douanier")
                    {
                        RunObject = report 70017;
                    }
                    action("Performance com")
                    {
                        Caption = 'Etat perforances pérodique';
                        RunObject = report 70021;
                        Image = Report;

                    }
                }
            }
        }
        area(Embedding)
        {
            action("Situation des caisses")
            {
                Image = CashFlow;
                RunObject = Page 70050;
            }
            action("Etat des depots")
            {
                Image = CashFlow;
                RunObject = report 70003;
            }
            //Commented by Fabrice Smart
            // action("Compte tiers")
            // {
            //     Image = Customer;
            //     RunObject = page "Compte tiers activity";
            // }




        }
    }
}