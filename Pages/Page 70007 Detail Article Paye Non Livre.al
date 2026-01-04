page 70017 "Detail Article Paye Non Livre"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Invoice Line";
    /*On filtre sur le statut livraison pour restraindre le nombre de resultat sinon pour un article on peut avoir 1000 ligne dont l'article a ete completement livré
   Alors qu'on ne recherhce que ceux qui sont <<Payée non livre ou payée partiellement livré*/
    //SourceTableView = where("Statut Livraison" = filter('=Payée Non livré|Payée partiellement livré'));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Article"; rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Facture"; rec."Document No.")
                {
                    ApplicationArea = All;

                }

                // silue samuel 07/03/2025 field("Carton commande"; rec."Carton effectif")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Cartons commandés';

                //fin silue samuel 07/03/2025 }
                field("Carton livre"; rec."Qté livrée")
                {
                    Caption = 'Cartons livrés';
                    ApplicationArea = All;

                }
                //  silue samuel 07/03/2025field("Carton non livre"; rec."Carton effectif" - Rec."Qté livrée")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Cartons non livrés';

                //fin silue samuel 07/03/2025 }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}