page 70115 Ligne_Paiement
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Weigh Bridge";
    // SourceTableView = where(Ticket_Concerne = const(false));

    layout
    {
        area(Content)
        {
            // group(Test)
            // {
            //     field(testtotal; testtotal)
            //     {
            //         ApplicationArea = All;
            //     }
            // }
            repeater(General)
            {


                field("Ticket Planteur"; "Ticket Planteur")
                {
                    Editable = false;
                }
                field("Type opération"; "Type opération")
                {

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
                field(Ticket_Concerne; Ticket_Concerne)
                {
                    ApplicationArea = All;
                    trigger OnValidate()

                    var
                        Paiement_Header: Page Paiement_Header;
                        myInt: Integer;
                        HeaderPaiement: Record Entete_Paiement;
                        Souche: Record Souche;
                        ItemWeightBridge: Record "Item Weigh Bridge";
                        ItemWeightBridge2: Record "Item Weigh Bridge";
                    begin

                        Souche.SetRange(User, UserId);
                        if Souche.FindLast() then begin
                            // if rec.Ticket_Concerne = true then begin
                            rec.NumDocExten := Souche.Code_Souche;
                            // end else begin
                            //     rec.Validate(NumDocExten, '');

                            // end;
                            // CurrPage.Update();

                        end;
                        SommeTotale();
                        HeaderPaiement.SetRange(NumDocExt, rec.NumDocExten);
                        if HeaderPaiement.FindFirst() then begin
                            if rec.Ticket_Concerne = true then begin
                                Rec.Beneficiaire := HeaderPaiement.Beneficiare;
                                REC.NCNI := HeaderPaiement.CNI;
                                REC.Mode_Paiement := HeaderPaiement.Mode_Paiement;
                                REC.Observation := HeaderPaiement.Observation;
                                REC.Telephone := HeaderPaiement.Telephone;
                                // Message('Yes FnGeek');
                            end;

                            //****
                            ItemWeightBridge.SetFilter(NumDocExten, '=%1', rec.NumDocExten);
                            ItemWeightBridge.SetFilter(Ticket_Concerne, '=%1', true);
                            ItemWeightBridge.SetFilter("Statut paiement Planteur", '=%1', false);
                            if ItemWeightBridge.FindSet() then begin
                                repeat begin

                                    // if ItemWeightBridge.Marqueur = false then begin
                                    HeaderPaiement.Poids_Total += rec."POIDS NET";
                                    HeaderPaiement.TotalPlanteur += rec.TotalPlanteur;
                                    HeaderPaiement.Impot += rec.Impot;
                                    HeaderPaiement.TotalPlanteurTTc += rec.TotalPlanteurTTc;
                                    // Message('Yes man');
                                    // Message('Ticket: %1 Poids: %2 RecPoids: %3', ItemWeightBridge."Ticket Planteur", HeaderPaiement.Poids_Total, rec."POIDS NET")
                                    // end;
                                    rec.Marqueur := TRUE;


                                end until ItemWeightBridge.Next() = 0;
                            end else begin
                                HeaderPaiement.Poids_Total := 0;
                                HeaderPaiement.TotalPlanteur := 0;
                                HeaderPaiement.Impot := 0;
                                HeaderPaiement.TotalRegime := 0;
                                HeaderPaiement.TotalPlanteurTTc := 0;
                                // Message('No man');
                            end;
                            HeaderPaiement.Modify();

                        end else begin
                            HeaderPaiement.Poids_Total := 0;
                            HeaderPaiement.TotalPlanteur := 0;
                            HeaderPaiement.Impot := 0;
                            HeaderPaiement.TotalPlanteurTTc := 0;
                            HeaderPaiement.Impot := 0;
                            HeaderPaiement.Modify();
                            // Message('No man2');
                        end;

                        if rec.Ticket_Concerne = false then begin
                            rec.Marqueur := false;
                            REC.TotalPlanteur := 0;
                            rec.TotalPlanteurTTc := 0;
                            rec.Impot := 0;
                            rec.PrixUnitaire := 0;
                            //FnGeek vider la table
                            rec.Beneficiaire := '';
                            REC.NCNI := '';
                            REc.Telephone := '';
                            rec.Observation := '';
                            rec.Date_Paiement := 0D;
                            rec.NumDocExten := '';
                            CurrPage.Update();
                        end;

                    end;
                }
                field(Marqueur; Marqueur)
                {
                    ApplicationArea = All;
                    Visible = false;
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
                field(Poids_Total; Poids_Total)
                {
                    ApplicationArea = All;
                    Visible = false;
                    // DecimalPlaces=3;     
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
        VendorSplitTaxSetup: Record "Vendor Split Tax Setup";
        taxe: Decimal;
    begin
        ParaCaisse.Reset();
        ParaCaisse.Get();
        // if REC."Statut paiement Planteur" = true then begin
        // Nom_Concerne := "Nom planteur";
        PrixAchat.setFilter("Purchase Type", '=%1', PrixAchat."Purchase Type"::"Vendor Posting Group");
        PrixAchat.SetFilter("Item No.", '=%1', 'RPH-9003');
        PrixAchat.SetFilter("Starting Date", '<=%1', rec."Weighing 1 Date");
        PrixAchat.SetFilter("Ending Date", '>=%1', rec."Weighing 1 Date");
        PrixAchat.SetRange(Type_Operation_Options, rec."Type opération");
        if PrixAchat.FindFirst() then begin
            // REC.PrixUnitaire := PrixAchat."Direct Unit Cost";
            //*** Taxe
            VendorSplitTaxSetup.SetRange("Vendor No.", rec."Code planteur");
            if VendorSplitTaxSetup.FindFirst() then begin
                if rec.Ticket_Concerne = true then begin
                    rec.PrixUnitaire := PrixAchat."Direct Unit Cost" - VendorSplitTaxSetup.Cost;
                    REC.Impot := (VendorSplitTaxSetup.Percentage / 100) * rec.PrixUnitaire * rec."POIDS NET";
                    taxe := (VendorSplitTaxSetup.Percentage / 100);
                    rec.TotalPlanteur := rec.PrixUnitaire * rec."POIDS NET";
                    rec.TotalPlanteurTTc := (rec.PrixUnitaire * rec."POIDS NET") - (rec.PrixUnitaire * rec."POIDS NET" * taxe);
                    REC.Modify();
                end else begin
                    rec.Marqueur := false;
                    REC.validate(TotalPlanteur, 0);
                    rec.Validate(TotalPlanteurTTc, 0);
                    rec.Impot := 0;
                    // CurrPage.Update();
                end;

            end else begin
                Message('La retenue impôt du fournisseur : %1 n''est pas configuré', VendorSplitTaxSetup."Vendor No.");
                rec.PrixUnitaire := PrixAchat."Direct Unit Cost" - VendorSplitTaxSetup.Cost;
                REC.Impot := (VendorSplitTaxSetup.Percentage / 100) * rec.PrixUnitaire * rec."POIDS NET";
                // taxe := (VendorSplitTaxSetup.Percentage / 100);
                rec.TotalPlanteur := rec.PrixUnitaire * rec."POIDS NET";
                rec.TotalPlanteurTTc := rec.PrixUnitaire* rec."POIDS NET";
                REC.Modify()
            end;
            //***tAXE

        end else begin
            Error('Le prix n''est pas configuré pour la période du %1', rec."Weighing 1 Date");
        end;

    end;

    local procedure UpdateTotals(): Decimal
    var
        Line: Record "Item Weigh Bridge";
        Total: Decimal;

    begin

        // Clear(Total);
        // if  then begin

        // end else begin

        // end;
        // if REC.Ticket_Concerne = true then begin
        //     Total += rec."POIDS NET";
        // end else begin
        //     Total -= rec."POIDS NET";
        // end;
        // exit(Total)

    end;

    local procedure Somme(): Decimal
    var
        myInt: Integer;
        sommetotal: Decimal;

    begin
        // Message('Total: %1',Rec.Poids_Total);
        Clear(testtotal);
        if REC.Ticket_Concerne = true then begin
            testtotal += rec.TotalPlanteur;
            sommetotal := testtotal;
            // Message('Totlal: %1 b: %2', Total, rec."POIDS NET");
        end else begin
            testtotal -= rec.TotalPlanteur;
            sommetotal := testtotal;
            // Message('Totlal: %1 b: %2', Total, rec."POIDS NET");
        end;
        exit(sommetotal)
    end;

    local procedure SommeImpot(): Decimal
    var
        myInt: Integer;
        sommetotal: Decimal;
        sommeImpot: Decimal;

    begin
        // Message('Total: %1',Rec.Poids_Total);
        Clear(sommeImpot);
        if REC.Ticket_Concerne = true then begin
            sommeImpot += rec.Impot;
            sommetotal := sommeImpot;
            // Message('Totlal: %1 b: %2', Total, rec."POIDS NET");
        end else begin
            sommeImpot -= rec.Impot;
            sommetotal := sommeImpot;
            // Message('Totlal: %1 b: %2', Total, rec."POIDS NET");
        end;
        exit(sommetotal)
    end;

    local procedure SommeTTC(): Decimal
    var
        myInt: Integer;
        sommetotal: Decimal;
        sommeTTc: Decimal;

    begin
        // Message('Total: %1',Rec.Poids_Total);
        Clear(sommeTTc);
        if REC.Ticket_Concerne = true then begin
            sommeTTc += rec.TotalPlanteurTTc;
            sommetotal := sommeTTc;
            // Message('Totlal: %1 b: %2', Total, rec."POIDS NET");
        end else begin
            sommeTTc -= rec.TotalPlanteurTTc;
            sommetotal := sommeTTc;
            // page.
            // Message('Totlal: %1 b: %2', Total, rec."POIDS NET");
        end;
        exit(sommetotal)
    end;

    // trigger O()
    // var
    //     myInt: Integer;
    // begin

    // end;
    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        //    page.

    end;

    var
        myInt: Integer;
        testtotal: Decimal;
        itemWeigBrig: Record "Item Weigh Bridge";

}