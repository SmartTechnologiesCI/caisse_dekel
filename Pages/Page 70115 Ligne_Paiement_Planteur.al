page 70115 Ligne_Paiement
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Weigh Bridge";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Ticket Planteur"; "Ticket Planteur")
                {

                }
                field("Code planteur"; "Code planteur")
                {
                    ApplicationArea = All;
                }
                field("Nom planteur"; "Nom planteur")
                {
                    ApplicationArea = All;
                }
                field("Code Transporteur"; "Code Transporteur")
                {
                    ApplicationArea = All;
                }
                field("Nom Transporteur"; "Nom Transporteur")
                {
                    ApplicationArea = All;
                }
                field(Beneficiaire; Beneficiaire)
                {

                }
                field("Statut paiement Planteur"; "Statut paiement Planteur")
                {
                    ApplicationArea = All;
                }
                field("POIDS ENTREE"; "POIDS ENTREE")
                {
                    ApplicationArea = all;

                }
                field("POIDS SORTIE"; "POIDS SORTIE")
                {
                    ApplicationArea = All;
                }
                field("POIDS NET"; "POIDS NET")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}