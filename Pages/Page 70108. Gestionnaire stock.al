profile "Gestionnaire stock"
{
    Description = 'Gestionnaire Stock';
    Caption = 'Gestionnaire Stock';
    RoleCenter = 70108;
    //Customizations = SalesLinesCustomizations;
}
page 70108 "Gestionnaire Stock"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part("Activités"; 70058)
            {

            }

        }
    }

    actions
    {
         area(Embedding)
        {

           
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
                //silue samuel 07/03/2025 RunObject = page 50063;
                RunPageMode = View;
            }
        }
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
            action("&Feuilles d'inventaire")
            {
                Caption = 'Feuilles d''inventaires';
                RunObject = page 392;
                RunPageMode = Create;
            }
            action("Articles vendu")
            {
                Caption = 'Articles vendus';
                RunObject = report 70002;
                RunPageMode=View;
            }
        }
        // area(Sections)
        // {
        //     group("Réception entrepôt")
        //     {
        //         action("Réception achat")
        //         {
        //             RunObject = Page 7332;
        //         }
        //         action("Réception achat enregistrées")
        //         {
        //             RunObject = Page 145;
        //         }
        //     }
        //     group("Expéditions")
        //     {
        //         action("Expédition ventes")
        //         {
        //             RunObject = Page 7339;
        //         }
        //         action("Expédition ventes enregistrées")
        //         {
        //             RunObject = Page 142;
        //         }

        //     }
        // }
    }
}