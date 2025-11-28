page 70116 ListePaiementPlanteur
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Entete_Paiement;
    CardPageId = Paiement_Header;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code_Transporteur; Code_Transporteur)
                {
                    ApplicationArea = All;
                }
                field(Nom_Transporteur; Nom_Transporteur)
                {
                    ApplicationArea = All;
                }
                field(Palanteur; Palanteur)
                {
                    ApplicationArea = All;
                }
                field(Nom_Planteur; Nom_Planteur)
                {
                    ApplicationArea = All;
                }
                field(Date_Paiement; Date_Paiement)
                {
                    ApplicationArea = All;
                }
                field(Beneficiare; Beneficiare)
                {
                    ApplicationArea = ALL;
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

                trigger OnAction()
                begin

                end;
            }
        }
    }
}