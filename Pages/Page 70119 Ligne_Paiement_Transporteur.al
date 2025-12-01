page 70119 Ligne_Paiement_Transporteur
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
                    Editable = false;
                }
                field(Ticket_Concerne; Ticket_Concerne)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        HeaderPaiement: Record Entete_Paiement_Transporteur;
                        Souche: Record Souche;
                    begin
                        // rec.TestField(NumDocExten);
                        Souche.SetRange(User, UserId);
                        if Souche.FindLast() then begin
                            rec.NumDocExten := Souche.Code_Souche;
                        end;
                        HeaderPaiement.SetRange(NumDocExt, rec.NumDocExten);
                        if HeaderPaiement.FindFirst() then begin
                            Rec.Beneficiaire := HeaderPaiement.Beneficiare;
                            REC.NCNI := HeaderPaiement.CNI;
                            REC.Mode_Paiement := HeaderPaiement.Mode_Paiement;
                            REC.Observation := HeaderPaiement.Observation;
                            REC.Telephone := HeaderPaiement.Telephone;
                        end;
                    end;
                }
                field(NumDocExten; rec.NumDocExten)
                {
                    ApplicationArea = All;
                }
                field("Code planteur"; "Code planteur")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Nom planteur"; "Nom planteur")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Code Transporteur"; "Code Transporteur")
                {
                    ApplicationArea = All;
                    // Visible = false;

                }
                field("Nom Transporteur"; "Nom Transporteur")
                {
                    ApplicationArea = All;
                    // Visible = false;

                }
                field("Type opération"; "Type opération")
                {
                    ApplicationArea = All;
                }
                field("Type of Transportation"; "Type of Transportation")
                {
                    ApplicationArea = All;
                }
                field(Beneficiaire; Beneficiaire)
                {

                }
                field(En_Attente_Paiement; En_Attente_Paiement)
                {
                    ApplicationArea = All;
                }
                field(NCNI; NCNI)
                {
                    ApplicationArea = All;
                }
                field(Mode_Paiement; Mode_Paiement)
                {
                    ApplicationArea = All;
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = All;
                }
                field(Observation; Observation)
                {

                }

                field("Statut paiement"; "Statut paiement")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("POIDS ENTREE"; "POIDS ENTREE")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("POIDS SORTIE"; "POIDS SORTIE")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("POIDS NET"; "POIDS NET")
                {
                    ApplicationArea = All;
                    Editable = false;
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