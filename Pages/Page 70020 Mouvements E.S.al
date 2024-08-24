page 70020 "Mouvements Entrées et sorties"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Mouvements Entrees Sorties";
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No Mvnt"; rec."No.")
                {

                    CaptionML = ENU = 'No.', FRA = 'N°';
                    ApplicationArea = All;
                    //Enabled = "Code caisse" <> '';
                    AssistEdit = true;
                    Editable = false;
                    trigger OnAssistEdit()
                    var
                    begin
                        if rec.AssistEdit_mvt(xRec) then
                            CurrPage.UPDATE;
                    end;
                }
                field("Code caisse"; rec."Code caisse")
                {
                    CaptionML = ENU = 'Cash Register code', FRA = 'Code caisse';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; rec.Date)
                {
                    CaptionML = ENU = 'Date', FRA = 'Date';
                    ApplicationArea = All;
                    Editable = false;
                    ShowMandatory = true;
                }
                field(Heure; rec.Heure)
                {
                    CaptionML = ENU = 'Time', FRA = 'Heure';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Mouvement")
            {
                Enabled = NOT rec.Validated;
                //Enabled = true;
                field(type; rec.type)
                {
                    CaptionML = ENU = 'Type', FRA = 'Type';
                    ApplicationArea = All;
                }
                field(Montant; rec.Montant)
                {
                    CaptionML = ENU = 'Amount', FRA = 'Montant';
                    ApplicationArea = All;
                }
                field(Motif; rec.Motif)
                {
                    CaptionML = ENU = 'Reason', FRA = 'Motif';
                    ApplicationArea = All;
                }
                field("User Id"; rec."User Id")
                {
                    CaptionML = ENU = 'User', FRA = 'Utilisateur';
                    ApplicationArea = All;
                    TableRelation = User."User Name";
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Valider)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Enabled = NOT rec.Validated;
                trigger OnAction()
                var
                    MouvTransaction: record Transactions;
                begin
                    if (Confirm(ConfirmSave)) then begin
                        MouvTransaction.Reset();
                        MouvTransaction.Source := Source::"E/S";
                        MouvTransaction."Code caisse" := rec."Code caisse";
                        MouvTransaction.Date := rec.Date;
                        MouvTransaction.Heure := rec.Heure;
                        MouvTransaction.Description := '';
                        MouvTransaction.Montant := rec.Montant;
                        MouvTransaction."Montant recu" := rec.Montant;
                        MouvTransaction."Montant NET" := rec.Montant;
                        MouvTransaction."N° Document" := rec."No.";
                        MouvTransaction."Mode de reglement" := 'ESPÈCES';
                        MouvTransaction."user id" := rec."User Id";
                        MouvTransaction.Description := rec.Motif;
                        MouvTransaction.Insert();
                        rec.Validated := true;
                        rec.Modify()
                    end;
                end;
            }
            action(Annuler)
            {

                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Enabled = NOT rec.Validated;
                trigger OnAction()
                var
                    MouvTransaction: Record "Transactions";
                    Mvnt: Record "Mouvements Entrees Sorties";
                begin
                    if (NOT rec.Validated) then begin
                        if (Confirm(cancelSave)) then begin
                            rec.Delete();
                            CurrPage.Close();
                        end;
                    end
                    else begin
                        if (Confirm(cancelSave)) then begin
                            MouvTransaction.Reset();
                            MouvTransaction.Source := Source::"E/S";
                            MouvTransaction."Code caisse" := rec."Code caisse";
                            MouvTransaction.Date := rec.Date;
                            MouvTransaction.Heure := rec.Heure;
                            MouvTransaction.Description := 'Annulation de du mouvement ' + rec."No.";
                            MouvTransaction.Montant := -rec.Montant;
                            MouvTransaction."Montant NET" := -rec.Montant;
                            MouvTransaction."N° Document" := rec."No.";
                            MouvTransaction."Mode de reglement" := 'ESPÈCES';
                            MouvTransaction."user id" := rec."User Id";
                            MouvTransaction.Insert();
                            rec.Validated := false;
                            rec.Modify();
                        end;
                    end;
                end;
            }
        }

    }

    trigger OnOpenPage()
    var
        Caisse: Record Caisse;
    begin
        /* Date := WorkDate;
         Heure := Time;
         "User Id" := UserId;
         Caisse.SetRange("User ID");
         if (Caisse.FindFirst()) then
             "Code caisse" := Caisse."Code caisse";
         CurrPage.Update();*/

        rec.SetCurrentKey(Date);
        rec.SetAscending(Date, false);
    end;

    var
        confirmSave: TextConst ENU = 'Would you like to save this transaction ?', FRA = 'Souhaitez-vous enregistrer cette transaction ?';
        cancelSave: TextConst ENU = 'Would you like to cancel this transaction ?', FRA = 'Souhaitez-vous annuler cette transaction ?';
}