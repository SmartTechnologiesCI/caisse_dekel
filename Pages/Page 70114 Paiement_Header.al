page 70114 Paiement_Header
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Entete_Paiement;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Palanteur_Transporteur; Palanteur_Transporteur)
                {
                    ApplicationArea = All;
                }
                field(Beneficiare; Beneficiare)
                {
                    ApplicationArea = All;
                }
                field(Date_Paiement; Date_Paiement)
                {
                    ApplicationArea = All;
                }
                field(Caissier; Caissier)
                {
                    ApplicationArea = All;
                }
            }
            part(Ligne_Paiement; Ligne_Paiement)
            {
                SubPageLink = "Code Transporteur" = field(Palanteur_Transporteur), "Code planteur" = field(Palanteur_Transporteur);

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