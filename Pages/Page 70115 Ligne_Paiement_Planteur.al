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
                        HeaderPaiement: Record Entete_Paiement;
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
                        //****Paiement
                        REC.Poids_Total += rec."POIDS NET";
                        REC.Modify();
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
    procedure SommeTotale()
    var
        myInt: Integer;
        PrixAchat: Record "Prix Achat";
        ParaCaisse: Record "Parametres caisse";
    begin
        ParaCaisse.Reset();
        ParaCaisse.Get();
        if REC."Statut paiement Planteur" = true then begin
            // Nom_Concerne := "Nom planteur";
            PrixAchat.setFilter("Purchase Type", '=%1', PrixAchat."Purchase Type"::"Vendor Posting Group");
            PrixAchat.SetFilter("Item No.", '=%1', 'RPH-9003');
            PrixAchat.SetFilter("Starting Date", '<=%1', rec."Date validation");
            PrixAchat.SetFilter("Ending Date", '>=%1', rec."Date validation");
            PrixAchat.SetRange(Type_Operation_Options, rec."Type opération");
            if PrixAchat.FindFirst() then begin
                REC.Impot := ParaCaisse.PoucentageImpot * PrixAchat."Direct Unit Cost" * rec."POIDS NET";
                rec.TotalPlanteur := PrixAchat."Direct Unit Cost" * rec."POIDS NET";
                rec.TotalPlanteurTTc := (PrixAchat."Direct Unit Cost" * rec."POIDS NET" * ParaCaisse.PoucentageImpot) + PrixAchat."Direct Unit Cost" * rec."POIDS NET";
                REC.Modify();
            end;
        end else begin
            if rec."Statut paiement" = true then begin
                // Nom_Concerne := "Driver Name";
                PrixAchat.setFilter("Purchase Type", '=%1', PrixAchat."Purchase Type"::"Vendor Posting Group");
                PrixAchat.SetFilter("Item No.", '=%1', 'TRANSPORT');
                PrixAchat.SetFilter("Starting Date", '<=%1', "Date validation");
                PrixAchat.SetFilter("Ending Date", '>=%1', "Date validation");
                PrixAchat.SetRange(Type_Operation_Options, "Type opération");
                if PrixAchat.FindFirst() then begin
                    rec.Impot := ParaCaisse.PoucentageImpot * PrixAchat."Direct Unit Cost" * rec."POIDS NET";
                    REC.Total := PrixAchat."Direct Unit Cost" * rec."POIDS NET";
                    REC.TotalTransPorteurTTC := (PrixAchat."Direct Unit Cost" * rec."POIDS NET" * ParaCaisse.PoucentageImpot) + (PrixAchat."Direct Unit Cost" * rec."POIDS NET");
                    REC.Modify()
                end;
            end;
        end;
    end;

    var
        myInt: Integer;
        testtotal: Decimal;
}