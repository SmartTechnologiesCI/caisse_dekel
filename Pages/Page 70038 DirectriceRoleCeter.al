profile "Directeur"
{
    Description = 'Directeur(trice)';
    CaptionML = ENU = 'Director', FRA = 'Directeur(trice)';
    RoleCenter = "Director RC";
    //Customizations = SalesLinesCustomizations;
}
page 70038 "Director RC"
{
    PageType = RoleCenter;
    SourceTable = "Director cue";
    layout
    {
        area(RoleCenter)
        {

            part("Headline"; 70052)
            {


            }
            // part("Compte tiers activity"; "Compte tiers activity")
            // {
            //     ApplicationArea = All;
            // }
            part("La Tulipe Food"; 70039)
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
            action("&Génerer echantillon douanier")
            {
                Caption = 'Générer echantillon douanier';
                //silue samuel 07/03/2025 RunObject = page 50055;
            }

            action("&Transfert de stock")
            {
                Caption = 'Transferer du stock';
                RunObject = page 5742;
                RunPageMode = Create;
            }
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
            group(Articles)
            {
                action("&Articles")
                {
                    ApplicationArea = All;
                    Caption = 'Articles';
                    RunObject = page "Item List";
                }
                action("F&euilles articles")
                {
                    ApplicationArea = All;
                    Caption = 'Feuilles articles';
                    RunObject = page 40;
                }
                action("Ajustement du stock")
                {
                    RunObject = Page 70067;
                }
                action("Transfert Magasin")
                {
                    RunObject = Page 5742;
                    Visible = false;
                }
                action("Mise a jour prix/Categories")
                {
                    RunObject = Page 70069;
                }
                action("Etat des stocks")
                {

                    RunObject = report 70014;
                }


                action("Valorisation des stocks")
                {

                    RunObject = report 70015;
                }
                action("Article payes non livres")
                {
                    ApplicationArea = All;
                    Caption = 'Articles payés nons livrés';
                    RunObject = Page 70006;
                }

                action("Liste transfert")
                {
                    ApplicationArea = All;
                    Caption = 'Transferts magasin';
                    RunObject = Page "Liste Transfert";
                }
            }
            group("Achats")
            {
                action("Commandes Achats")
                {
                    RunObject = Page "Purchase Order List";
                }
                action("Factures Achats")
                {
                    Visible = false;
                    RunObject = Page 9308;
                }
                action("Génerer echantillon douanier")
                {
                    //silue samuel 07/03/2025 RunObject = page 50055;
                }
            }
            group("Ventes")
            {
                action("Commandes ventes")
                {
                    RunObject = Page "Sales order List";
                }
                action("Factures ventes")
                {
                    RunObject = Page 9301;
                }
                group("Performance commercial")
                {
                    action(Groupe)
                    {
                        RunObject = page Teams;
                    }
                    action("Taches")
                    {
                        RunObject = Page 70080;
                    }
                    action("Performance")
                    {
                        Visible = false;
                        RunObject = report 70020;
                    }
                    action("Performance new")
                    {
                        Caption = 'Etat performances pérodique';
                        RunObject = report 70021;
                    }
                    action("Prime par commercial")
                    {
                        Caption = 'Prime par commercial';
                        RunObject = report 70024;
                    }
                    action("Performance peseur")
                    {
                        //Visible = false;
                        RunObject = report 70022;
                    }


                }
            }
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


                action(crediteur)
                {
                    Caption = 'Dépôts actifs';
                    ApplicationArea = All;
                    RunObject = Page 70051;


                }

                action(epargne)
                {
                    Caption = 'Compte épargne clients';
                    ApplicationArea = All;
                    RunObject = Page 70049;


                }


            }
            group(Etats)
            {

                group("Etat Contrôle livraison")
                {
                    action("Etat Contrôle livraison par client")
                    {
                        RunObject = Report 70005;
                    }
                    action("Etat Contrôle livraison par article")
                    {
                        RunObject = Report 70006;
                    }
                    action("Etat Articles à stock négatif")
                    {
                        RunObject = Report 70044;
                    }
                    action("Etat Factures validées à date")
                    {
                        RunObject = Report 70047;
                    }
                }
                group(statistiques)
                {
                    action("Articles vendu")
                    {
                        Caption = 'Articles vendus';
                        RunObject = report 70002;
                    }
                    action("Etat des ventes par articles")
                    {
                        Caption = 'Statistiques des ventes';
                        RunObject = report 70007;
                    }
                    action("Etat des ventes par article")
                    {
                        Visible = false;
                        RunObject = report 70019;
                    }
                    action("Palmarès des clients")
                    {
                        RunObject = report 70010;
                    }
                    action("Palmarès des Fournisseurs")
                    {
                        RunObject = report 70018;
                    }

                    action("Palmarès des Categories Article")
                    {
                        RunObject = report 70042;
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
            action("Articles vendus")
            {
                Image = Item;
                RunObject = Report 70002;
            }
            // action("Compte tiers")
            // {
            //     Image = Customer;
            //     RunObject = page "Compte tiers activity";
            //     ApplicationArea=All;
            // }
            action("ArticlesP")
            {
                CaptionML = FRA = 'PAA : Articles en stock et prix';
                //silue samuel 07/03/2025 RunObject = page 50064;
                RunPageMode = View;
            }

            action("ArticlesB")
            {
                CaptionML = FRA = 'Bietry : Articles en stock et prix';
                //silue samuel 07/03/2025 RunObject = page 50062;
                RunPageMode = View;
            }


            action("ArticlesV")
            {
                CaptionML = FRA = 'Vridi : Articles en stock et prix';
                // silue samuel 07/03/2025 RunObject = page 50063;
                RunPageMode = View;
            }
        }
    }
}