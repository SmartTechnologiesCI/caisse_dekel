page 70132 EnteteTransfert
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = EntetTransfert;
    Caption = 'Transfet de fonds';

    layout
    {
        area(Content)
        {
            group(Général)
            {
                field(Caissier; Caissier)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        rec.Modify()
                    end;
                }
                field(Caisse; Caisse)
                {
                    ApplicationArea = All;
                    trigger OnValidate()

                    var
                        myInt: Integer;
                        caisse: Record Caisse;
                    begin
                        caisse.SetRange("Code caisse", rec.Caisse);
                        if caisse.FindFirst() then begin
                            REC.validate(Caissier, caisse."User ID");
                            // rec.Modify()
                        end;
                        CurrPage.Update();
                    end;
                }
                field(Solde; Solde)
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    // Editable = false;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        Transaction: Record Transactions;
                    begin
                        Transaction.SetFilter("user id", reC.Caissier);
                        if Transaction.FindSet() then begin
                            page.Run(page::"Liste des transactions", Transaction);
                        end;
                    end;
                }
                field(NumDocExtern; NumDocExtern)
                {
                    ApplicationArea = All;
                }
                field(Observation; Observation)
                {
                    ApplicationArea = All;
                }
                field(DateTransFert; DateTransFert)
                {
                    ApplicationArea = All;
                }
            }
            part(LigneTransFert; LigneTransFert)
            {
                Caption = 'Lignes Transfert';
                ApplicationArea = All;
                SubPageLink = IDLIGNETRANSFERT = field(IDTRANSFERT), NumDocExtern = field(NumDocExtern);

            }

        }

    }

    actions
    {
        area(Processing)
        {
            action(Valider)
            {
                Caption = 'Valider transfert';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Caisse: Record Caisse;
                    Transaction: Record Transactions;
                    LigneTransfert: Record LigneTransFert;
                begin
                    if Confirm('Voulez-vous valider la transaction ?') then begin
                        LigneTransfert.SetFilter(IDLIGNETRANSFERT, '=%1', rec.IDTRANSFERT);
                        LigneTransfert.SetFilter(NumDocExtern, '=%1', rec.NumDocExtern);
                        if LigneTransfert.FindSet() then begin
                            repeat begin
                                TransactionDirect(LigneTransfert);
                            end until LigneTransfert.Next() = 0;
                        end;

                        //Déduction de la caisse principal

                        LigneTransfert.SetFilter(IDLIGNETRANSFERT, '=%1', rec.IDTRANSFERT);
                        LigneTransfert.SetFilter(NumDocExtern, '=%1', rec.NumDocExtern);
                        if LigneTransfert.FindSet() then begin
                            repeat begin
                                TransfertIndirect(LigneTransfert);
                            end until LigneTransfert.Next() = 0;
                            rec.valide := true;
                            rec.Modify();
                        end;
                        Message('Transaction éffectuée avec succès');
                    end else begin
                        exit;
                    end;


                    // Page.Run(page::ListTransfert);
                end;
            }
        }
    }
    procedure TransactionDirect(LigneTransfert: Record LigneTransFert)
    var
        myInt: Integer;
        Transaction: Record Transactions;
    begin
        Transaction.Reset();
        Transaction.Init();
        Transaction.Source := Transaction.Source::"Transfert de fond";
        Transaction.Date := WorkDate();
        Transaction.Heure := Time;
        Transaction.Description := LigneTransfert.NumDocExtern + ' ' + rec.Caissier + ' ' + Format(LigneTransfert.Montant);
        Transaction.Montant := LigneTransfert.Montant;
        Transaction."Code caisse" := LigneTransfert.caisse;
        Transaction."N° Document" := LigneTransfert.NumDocExtern;
        Transaction."Mode de reglement" := Format(LigneTransfert.ModeReglement);
        Transaction."user id" := rec.Caissier;
        Transaction."Montant NET" := LigneTransfert.Montant;
        Transaction."Origine Operation" := LigneTransfert.caisse;
        Transaction.DocExtern := LigneTransfert.NumDocExtern;
        Transaction.Insert();
    end;

    procedure TransfertIndirect(LigneTransfert: Record LigneTransFert)
    var
        myInt: Integer;
        Transaction: Record Transactions;
    begin
        Transaction.Reset();
        Transaction.Init();
        Transaction.Source := Transaction.Source::"Transfert de fond";
        Transaction.Date := WorkDate();
        Transaction.Heure := Time;
        Transaction.Description := LigneTransfert.NumDocExtern + ' ' + rec.Caissier + ' ' + Format(LigneTransfert.Montant);
        Transaction.Montant := -LigneTransfert.Montant;
        Transaction."Code caisse" := rec.Caisse;
        Transaction."N° Document" := LigneTransfert.NumDocExtern;
        Transaction."Mode de reglement" := Format(LigneTransfert.ModeReglement);
        Transaction."user id" := rec.Caissier;
        Transaction."Montant NET" := -LigneTransfert.Montant;
        Transaction."Origine Operation" := LigneTransfert.caisse;
        Transaction.DocExtern := LigneTransfert.NumDocExtern;
        Transaction.Insert();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        REC.DateTransFert := WorkDate();
        // CurrPage.Update();
    end;

    


    var
        myInt: Integer;
}