page 70114 Paiement_Header
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Entete_Paiement;
    InsertAllowed = true;
    ModifyAllowed = true;
    Caption = 'Multiple paiement Planteur';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Code_Transporteur; Code_Transporteur)
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.SetRange("Ticket Planteur", rec.Palanteur);
                        if ItemWeighBridge.FindFirst() then begin
                            rec.Nom_Planteur := Nom_Planteur;
                        end;


                    end;

                }
                field(Nom_Transporteur; Nom_Transporteur)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Palanteur; Palanteur)
                {
                    ApplicationArea = All;
                    // TableRelation = "Item Weigh Bridge"."Code planteur";
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.SetRange("Code planteur", rec.Palanteur);
                        if ItemWeighBridge.FindFirst() then begin
                            rec.Nom_Planteur := ItemWeighBridge."Nom planteur";
                            // rec.Modify();
                        end;


                    end;
                }
                field(Nom_Planteur; Nom_Planteur)
                {
                    ApplicationArea = All;
                    Editable = false;
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
                SubPageLink = "Code planteur" = field(Palanteur), "Statut paiement Planteur" = const(false);

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Valider)
            {
                Caption = 'Valider paiement';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}