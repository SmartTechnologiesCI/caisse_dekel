page 70123 Ligne_Paiement_Achive_Planteur
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Weigh Bridge";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

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
                field(NumDocExten; rec.NumDocExten)
                {
                    ApplicationArea = All;
                }
                field(CLpaiement; REC.CLpaiement)
                {
                    ApplicationArea = All;
                }
                field("Weighing 1 Date"; "Weighing 1 Date")
                {
                    ApplicationArea = All;
                }
                field("Weighing 2 Date"; "Weighing 2 Date")
                {
                    ApplicationArea = All;
                }
                field("Date validation"; "Date validation")
                {
                    ApplicationArea = All;
                }
                field(Ticket_Concerne; Ticket_Concerne)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        HeaderPaiement: Record Entete_Paiement;
                    begin
                        rec.TestField(NumDocExten);
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

                field("Code planteur"; "Code planteur")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Nom planteur"; "Nom planteur")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Code Transporteur"; "Code Transporteur")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Nom Transporteur"; "Nom Transporteur")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field(Beneficiaire; Beneficiaire)
                {

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

                field("Statut paiement Planteur"; "Statut paiement Planteur")
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