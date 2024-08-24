page 70007 "Detail Article Paye Non Livre"
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

                field("Carton commande"; rec."Carton effectif")
                {
                    ApplicationArea = All;
                    Caption = 'Cartons commandés';

                }
                field("Carton livre"; rec."Qté livrée")
                {
                    Caption = 'Cartons livrés';
                    ApplicationArea = All;

                }
                field("Carton non livre"; rec."Carton effectif" - Rec."Qté livrée")
                {
                    ApplicationArea = All;
                    Caption = 'Cartons non livrés';

                }

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