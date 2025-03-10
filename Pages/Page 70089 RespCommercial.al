page 70089 "Resp. Commer. Role Centers"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part("Activites"; 70092)
            {


            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }

        }
    }

    actions
    {

        area(Creation)
        {
            action("&&Génerer echantillon douanier")
            {
                Caption = 'Générer echantillon douanier';
                //silue samuel 07/03/2025 RunObject = page 50055;
            }

            action("&Transfert de stock")
            {
                Caption = 'Transferer du stock';
                RunObject = page "Transfert de stock";
                RunPageMode = Create;
            }

            action("Articles Vendus")
            {
                Caption = 'Articles vendus';
                RunObject = report "Article vendu2";
            }
        }

        area(Sections)
        {
            group(Etats)
            {
                action("Etat liste des articles à stock négatif ")
                {
                    Caption = 'Articles à stock négatif ';
                    RunObject = report 70044;
                    Promoted = true;
                    PromotedCategory = Report;
                }
            }
            group(Articles)
            {
                action("Liste transfert")
                {
                    ApplicationArea = All;
                    Caption = 'Transferts magasin';
                    RunObject = Page "Liste Transfert";
                }
                action("ArticleEnStock")
                {
                    Caption = 'Article en stock et prix';
                    RunObject = Page 50018;
                }

                action("ArticlesB")
                {
                    CaptionML = FRA = 'Bietry : Articles en stock et prix';
                    RunObject = page 50062;
                    RunPageMode = View;
                }


                action("ArticlesV")
                {
                    CaptionML = FRA = 'Vridi : Articles en stock et prix';
                    //silue samuel 07/03/2025 RunObject = page 50063;
                    RunPageMode = View;
                }
            }
            group("Commerciaux")
            {
                action("&Commerciaux")
                {
                    Caption = 'Commerciaux';
                    RunObject = Page 14;
                }
                action("Ventes par commerciale")
                {
                    Caption = 'Ventes par commerciale';
                    RunObject = report 50007;
                }
            }
            group("Echantillon")
            {
                Caption = 'Echantillon douanier';

                action("&Génerer echantillon douanier")
                {
                    Caption = 'Echantillon douanier';
                    //silue samuel 07/03/2025 RunObject = page 50055;
                    RunPageMode = Create;
                }
            }
            group("Performances commerciales")
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
        area(Embedding)
        {

            action("ArticlesPP")
            {
                CaptionML = FRA = 'PAA : Articles en stock et prix';
                //silue samuel 07/03/2025 RunObject = page 50064;
                RunPageMode = View;
            }

            action("ArticlesBB")
            {
                CaptionML = FRA = 'Bietry : Articles en stock et prix';
                //silue samuel 07/03/2025 RunObject = page 50062;
                RunPageMode = View;
            }

            action("ArticlesVV")
            {
                CaptionML = FRA = 'Vridi : Articles en stock et prix';
                // silue samuel 07/03/2025 RunObject = page 50063;
                RunPageMode = View;
            }


        }
    }
}

