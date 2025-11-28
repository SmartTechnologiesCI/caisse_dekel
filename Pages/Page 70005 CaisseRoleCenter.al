profile "Caisse"
{
    Description = 'Caissier(e)';
    CaptionML = ENU = 'Cash register', FRA = 'Caissier(e)';
    RoleCenter = "Caisse RoleCenter";
    //Customizations = SalesLinesCustomizations;
}
page 70005 "Caisse RoleCenter"
{
    PageType = RoleCenter;
    SourceTable = "Caisse Cue";
    layout
    {
        area(RoleCenter)
        {

            // part("Activités de caisse"; 70035)
            // {
            //     Caption = 'Activités de caisse';
            //     ApplicationArea = All;
            // }
            //<<Ticket diu jour 15_04_25
            part("Caisse cue"; "Caisse cue")
            {
                ApplicationArea = All;
                Caption = 'Tickets';

            }
            /*part("Commandes antérieures"; 70029)
            {
                ApplicationArea = All;
            }*/
        }
    }

    actions
    {
        area(Creation)
        {
            action("Dépots")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70004;
                RunPageMode = Create;
            }
            action("Mouvements Entrées et sorties")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70020;
                RunPageMode = Create;

            }

        }
        area(Embedding)
        {
            action("Ouverture de caisse")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70022;
            }
            action("Clôture de caisse")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70027;
            }
            action(Paiement_Multiple)
            {
                Caption = 'Paiement Multiple';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70114;
            }


            action("Liste des encaissements")
            {

                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70033;
            }
            action("Liste des dépots")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70003;
            }
            action("Liste des mouvements de caisse")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70021;
            }
            action("Liste des transactions")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70002;
            }

            action("Compte tiers d")
            {
                Caption = 'INFOS CLIENTS ';
                Image = Customer;
                RunObject = page "Compte tiers activity Caisse";
            }

        }

    }
}