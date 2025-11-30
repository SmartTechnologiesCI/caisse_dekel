page 70116 ListePaiementPlanteur
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Entete_Paiement;
    CardPageId = Paiement_Header;
    SourceTableView = where(Archive = const(false));
    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(Code_Transporteur; Code_Transporteur)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Nom_Transporteur; Nom_Transporteur)
                {
                    ApplicationArea = All;
                    Visible = false;
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
                field(Archive; Archive)
                {
                    ApplicationArea = All;
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