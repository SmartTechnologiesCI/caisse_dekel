page 70119 Ligne_Paiement_Transporteur
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Weigh Bridge";
    Caption = 'Ligne Transport';

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
                field(Ticket_Concerne_Transport; Ticket_Concerne_Transport)
                {
                    ApplicationArea = All;
                    // trigger OnValidate()
                    // var
                    //     myInt: Integer;
                    //     HeaderPaiement: Record Entete_Paiement_Transporteur;
                    //     Souche: Record Souche;
                    // begin
                    //     // rec.TestField(NumDocExten);
                    //     Souche.SetRange(User, UserId);
                    //     if Souche.FindLast() then begin
                    //         rec.NumDocExten := Souche.Code_Souche;
                    //     end;
                    //     HeaderPaiement.SetRange(NumDocExt, rec.NumDocExten);
                    //     if HeaderPaiement.FindFirst() then begin
                    //         Rec.Beneficiaire := HeaderPaiement.Beneficiare;
                    //         REC.NCNI := HeaderPaiement.CNI;
                    //         REC.Mode_Paiement := HeaderPaiement.Mode_Paiement;
                    //         REC.Observation := HeaderPaiement.Observation;
                    //         REC.Telephone := HeaderPaiement.Telephone;
                    //     end;
                    // end;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        HeaderPaiement: Record Entete_Paiement_Transporteur;
                        Souche: Record Souche;
                        ItemWeightBridge: Record "Item Weigh Bridge";
                        ItemWeightBridge2: Record "Item Weigh Bridge";
                    begin

                        Souche.SetRange(User, UserId);
                        if Souche.FindLast() then begin
                            rec.NumDocExten := Souche.Code_Souche;
                        end;
                        SommeTotale();
                        HeaderPaiement.SetRange(NumDocExt, rec.NumDocExten);
                        if HeaderPaiement.FindFirst() then begin
                            Rec.Beneficiaire := HeaderPaiement.Beneficiare;
                            REC.NCNI := HeaderPaiement.CNI;
                            REC.Mode_Paiement := HeaderPaiement.Mode_Paiement;
                            REC.Observation := HeaderPaiement.Observation;
                            REC.Telephone := HeaderPaiement.Telephone;

                            //****
                            ItemWeightBridge.SetFilter(NumDocExten, '=%1', rec.NumDocExten);
                            ItemWeightBridge.SetFilter(Ticket_Concerne_Transport, '=%1', true);
                            ItemWeightBridge.SetFilter("Statut paiement", '=%1', false);
                            if ItemWeightBridge.FindSet() then begin
                                repeat begin

                                    if ItemWeightBridge.Marqueur = false then begin
                                        HeaderPaiement.Poids_Total += rec."POIDS NET";
                                        HeaderPaiement.TotalPlanteur += rec.TotalPlanteur;
                                        HeaderPaiement.Impot += rec.Impot;
                                        HeaderPaiement.TotalPlanteurTTc += rec.TotalPlanteurTTc;
                                        // Message('Ticket: %1 Poids: %2 RecPoids: %3', ItemWeightBridge."Ticket Planteur", HeaderPaiement.Poids_Total, rec."POIDS NET")
                                    end;
                                    rec.Marqueur := TRUE;

                                end until ItemWeightBridge.Next() = 0;
                            end;
                            HeaderPaiement.Modify();

                        end;
                    end;

                }
                field(Marqueur; Marqueur)
                {
                    ApplicationArea = All;
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
                field(PrixUnitaire; PrixUnitaire)
                {
                    ApplicationArea = All;
                }

                field(Impot; Impot)
                {
                    ApplicationArea = All;
                    // DecimalPlaces=3;
                }
                field(TotalPlanteur; TotalPlanteur)
                {
                    ApplicationArea = All;
                    // DecimalPlaces=3;
                }
                field(TotalPlanteurTTc; TotalPlanteurTTc)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 3;
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


            }
        }
    }

    actions
    {
        area(Processing)
        {
            // action(ActionName)
            // {

            //     trigger OnAction()
            //     begin

            //     end;
            // }
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
        // if REC."Statut paiement Planteur" = true then begin
        // Nom_Concerne := "Nom planteur";
        PrixAchat.setFilter("Purchase Type", '=%1', PrixAchat."Purchase Type"::"Vendor Posting Group");
        PrixAchat.SetFilter("Item No.", '=%1', 'TRANSPORT');
        PrixAchat.SetFilter("Starting Date", '<=%1', rec."Weighing 1 Date");
        PrixAchat.SetFilter("Ending Date", '>=%1', rec."Weighing 1 Date");
        PrixAchat.SetRange(Type_Operation_Options, rec."Type opération");
        if PrixAchat.FindFirst() then begin
            REC.PrixUnitaire := PrixAchat."Direct Unit Cost";
            REC.Impot := ParaCaisse.PoucentageImpot * PrixAchat."Direct Unit Cost" * rec."POIDS NET";
            rec.TotalPlanteur := PrixAchat."Direct Unit Cost" * rec."POIDS NET";
            rec.TotalPlanteurTTc := (PrixAchat."Direct Unit Cost" * rec."POIDS NET" * ParaCaisse.PoucentageImpot) + PrixAchat."Direct Unit Cost" * rec."POIDS NET";
            REC.Modify();
        end else begin
            Error('Le prix n''est pas configuré pour la période du %1', rec."Weighing 1 Date");
        end;

    end;

    var
        myInt: Integer;
}