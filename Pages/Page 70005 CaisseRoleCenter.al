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
                Visible = false;
            }
            action("Mouvements Entrées et sorties")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70020;
                RunPageMode = Create;
                Visible = false;

            }

        }
        area(Sections)
        {

            group(Historiques)
            {
                action(HistoriquesPlanteur)
                {
                    Promoted = True;
                    ApplicationArea = All;
                    PromotedCategory = Category12;
                    Caption = 'Archives paiement planteur';
                    RunObject = page ListePantPlanteurArchive;

                }
                action(HistoriquesTransporteur)
                {
                    Promoted = True;
                    ApplicationArea = All;
                    PromotedCategory = Category12;
                    Caption = 'Archives paiement Transporteur';
                    RunObject = page ListePantTransporteurArchive;

                }

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
                Caption = 'Paiement Multiple Planteur';
                Promoted = true;
                PromotedCategory = Process;
                RunPageMode = Create;
                ApplicationArea = All;
                RunObject = Page 70116;
            }
            action(Paiement_Multiple_Transp)
            {
                Caption = 'Paiement Multiple Transporteur';
                Promoted = true;
                PromotedCategory = Process;
                RunPageMode = Create;
                ApplicationArea = All;
                RunObject = Page ListePaiementTransporteur;
            }
            action(ImpressionPaimentPlanter)
            {
                Caption = 'Impression en masse planteur';
                Promoted = true;
                PromotedCategory = Process;
                RunPageMode = Create;
                ApplicationArea = All;
                RunObject = report 70048;
                Visible = false;
            }
            action(ImpressionTansporrteur)
            {
                Caption = 'Impression en masse Transporteur';
                Promoted = true;
                PromotedCategory = Process;
                RunPageMode = Create;
                ApplicationArea = All;
                RunObject = report 70048;
                Visible = false;
            }
            action("Recap")
            {
                Caption = 'Etat des bons de paiement transport';
                RunObject = report 50501;
                ApplicationArea = All;
            }

            action("Historique")
            {
                Caption = 'Les tickets validés';
                RunObject = Page TicketsPayes;
                ApplicationArea = All;
            }
            action("Ciasse")
            {
                Caption = 'caisse';
                RunObject = Page PointCaisses;
                // RunPageLink = "User ID" =usu
                ApplicationArea = All;

            }



            action("Liste des encaissements")
            {

                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70033;
                Visible = false;
            }
            action("Liste des dépots")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70003;
                Visible = false;
            }
            action("Liste des mouvements de caisse")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70021;
                Visible = false;
            }
            action("Liste des transactions")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70002;
                // Visible = false;
            }

            action("Compte tiers d")
            {
                Caption = 'INFOS CLIENTS ';
                Image = Customer;
                RunObject = page "Compte tiers activity Caisse";
                Visible = false;
            }

        }


    }
    // trigger OnOpenPage()
    // var
    //     myInt: Integer;
    // begin

    // end;
}