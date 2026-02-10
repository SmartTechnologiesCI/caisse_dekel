page 70117 ListePaiementTransporteur
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Entete_Paiement_Transporteur;
    CardPageId = Paiement_Header_Transporteur;
    SourceTableView = where(Archive = const(false));
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(NumDocExt; NumDocExt)
                {
                    visible = false;
                }
                field(NumeroDocTransport; rec.NumeroDocTransport)
                {
                    ApplicationArea = All;
                }
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