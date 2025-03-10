page 70004 "Fiche dépot"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Depôt;
    //DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("N°"; rec."N°")
                {

                    CaptionML = ENU = 'No.', FRA = 'N°';
                    ApplicationArea = All;
                    //Enabled = "Code caisse" <> '';
                    AssistEdit = true;
                    Editable = false;
                    trigger OnAssistEdit()
                    var
                    begin
                        if rec.AssistEdit_depot(xRec) then
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
                field(Correction; rec.Correction)
                {
                    Caption = 'Autorisation';
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        usep: Record 91;
                    begin
                        usep.get(UserId);
                        // if usep.Director or usep.CorrectioDepot then
                        //     exit
                        // else
                        //     Error('Vous n''êtes pas autorisé à realiser cette action, veillez demander une autorisation');


                    end;

                }
            }
            group("Dépôts")
            {
                Enabled = NOT rec.Validated;
                field("N° client"; rec."N° client")
                {
                    ApplicationArea = All;
                }

                field("Nom du client"; rec."Nom du client")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Mode de paiement"; rec."Mode de paiement")
                {
                    ApplicationArea = All;
                }
                field("Origine Operation"; rec."Origine Operation")
                {
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
                /*field(isBonus; isBonus)
                {
                    Caption = 'Epargne';
                }
                field(validated; validated)
                {

                }*/
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
                    reglementEntry3: record 81;
                    reglementEntry2: record 81;
                    reglementEntry: record 81;
                    LineNo: Integer;
                    depot: record "Depôt";
                begin
                    if (Confirm(ConfirmSave)) then begin
                        rec.TestField("Origine Operation");
                        //    if (rec.Montant < 0) and (rec.Correction = false) then
                        if (rec."Mode de paiement" <> 'ESPÈCES') and (rec.Correction = false) then
                            Error('Vous n''êtes pas autoriser à realiser cette action, veillez demander une autorisation');

                        MouvTransaction.Reset();
                        MouvTransaction.Source := Source::Depot;
                        MouvTransaction."Code caisse" := rec."Code caisse";
                        MouvTransaction.Date := rec.Date;
                        MouvTransaction.Heure := rec.Heure;
                        MouvTransaction.Description := 'Dépôt du client: ' + rec."Nom du client";
                        MouvTransaction.Montant := rec.Montant;
                        MouvTransaction."Montant recu" := rec.Montant;
                        MouvTransaction."Montant NET" := rec.Montant;
                        MouvTransaction."N° Document" := rec."N°";
                        MouvTransaction."Mode de reglement" := rec."Mode de paiement";
                        MouvTransaction."Origine Operation" := rec."Origine Operation";
                        MouvTransaction."user id" := rec."User Id";
                        MouvTransaction."N° Client" := rec."N° client";
                        MouvTransaction.Insert();
                        rec.Validated := true;
                        rec.Modify();
                        commit();

                        reglementEntry2.SetRange("Journal Template Name", 'REGLEMENT');
                        reglementEntry2.SetRange("Journal Batch Name", Caisse."Code caisse");
                        if (reglementEntry2.FindLast()) then
                            LineNo := reglementEntry2."Line No." + 10000
                        else
                            LineNo := 10000;
                        reglementEntry.Reset();
                        reglementEntry."Journal Template Name" := 'REGLEMENT';
                        reglementEntry.Validate("Journal Template Name");
                        reglementEntry."Journal Batch Name" := Caisse."Code caisse";
                        reglementEntry.Validate("Journal Batch Name");
                        reglementEntry."Line No." := LineNo;
                        reglementEntry."Posting Date" := WorkDate;
                        reglementEntry.Validate("Posting Date");
                        reglementEntry."Document Type" := reglementEntry."Document Type"::Payment;
                        if rec.Montant < 0 then reglementEntry."Document Type" := reglementEntry."Document Type"::" ";
                        reglementEntry.Validate("Document Type");
                        reglementEntry."Document No." := 'Depot' + rec."N°";
                        if rec.Montant < 0 then begin
                            reglementEntry."Document No." := 'CDepot' + rec."N°";

                        end;

                        reglementEntry.Validate("Document No.");
                        reglementEntry."Source Code" := 'VTEREGLT';
                        reglementEntry."Account Type" := reglementEntry."Account Type"::"Bank Account";
                        reglementEntry.Validate("Account Type");
                        reglementEntry."Account No." := Caisse."Code caisse";
                        reglementEntry.Validate("Account No.");

                        reglementEntry.Description := 'Dépôt du client: ' + rec."Nom du client";
                        if rec.Montant < 0 then reglementEntry.Description := 'Correction Dépôt: ' + rec."Nom du client";
                        reglementEntry."Bal. Account Type" := reglementEntry."Bal. Account Type"::Customer;
                        reglementEntry."Bal. Account No." := rec."N° client";



                        reglementEntry.Validate("Bal. Account No.");

                        /* if rec.Montant < 0 then begin

                             reglementEntry."Applies-to Doc. Type" := reglementEntry."Applies-to Doc. Type"::Payment;
                             reglementEntry."Applies-to Doc. No." := 'Depot' + rec."N°";
                         end;*/

                        reglementEntry.Amount := rec.Montant;
                        reglementEntry."Amount (LCY)" := rec."Montant";
                        reglementEntry.Validate(Amount);
                        reglementEntry.Validate("Amount (LCY)");
                        reglementEntry."Debit Amount" := rec."Montant";
                        reglementEntry.Validate("Debit Amount");
                        reglementEntry.Insert();

                        reglementEntry3.Reset();
                        reglementEntry3.SetRange("Journal Template Name", 'REGLEMENT');
                        reglementEntry3.SetRange("Journal Batch Name", Caisse."Code caisse");
                        reglementEntry3.SetRange("Document No.", 'Depot' + rec."N°");
                        if (reglementEntry3.FindFirst()) then begin
                            Hide := true;
                            postLedger.OnBeforeCode(reglementEntry3, Hide);
                            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", reglementEntry3);
                        end;
                        Commit();
                        depot.Reset();
                        depot.SetRange("N°", rec."N°");
                        if (depot.FindFirst()) then
                            Report.run(70003, true, true, depot);
                    end;
                end;
            }


            action(DemandeApprobation)
            {
                Caption = 'Demande d''Approbation';
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Voulez-vous soumettre le dépôt à approbation ?') then begin
                        //  silue samuel 07/03/2025 rec.DemandeApprobation := true;
                        Message('Demande de validation envoyé avec succès');
                        CurrPage.Close();
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
                    reglementEntry3: record 81;
                    reglementEntry2: record 81;
                    reglementEntry: record 81;
                    LineNo: Integer;
                begin
                    if (NOT rec.Validated) then begin
                        if (Confirm(cancelSave)) then begin
                            rec.Delete();
                            CurrPage.Close();
                        end;
                    end
                    /*else begin
                        if (Confirm(cancelSave)) then begin
                            MouvTransaction.Reset();
                            MouvTransaction.Source := Source::Depot;
                            MouvTransaction."Code caisse" := rec."Code caisse";
                            MouvTransaction.Date := rec.Date;
                            MouvTransaction.Heure := rec.Heure;
                            MouvTransaction.Description := 'Annulation du dépot de: ' + rec."Nom du client";
                            MouvTransaction.Montant := -rec.Montant;
                            MouvTransaction."N° Document" := rec."N°";
                            MouvTransaction."Mode de reglement" := rec."Mode de paiement";
                            MouvTransaction."user id" := rec."User Id";
                            MouvTransaction."N° Client" := rec."N° client";
                            MouvTransaction.Insert();
                            rec.Validated := false;
                            rec.Modify();

                            commit();

                            reglementEntry2.SetRange("Journal Template Name", 'REGLEMENT');
                            reglementEntry2.SetRange("Journal Batch Name", Caisse."Code caisse");
                            if (reglementEntry2.FindLast()) then
                                LineNo := reglementEntry2."Line No." + 10000
                            else
                                LineNo := 10000;
                            reglementEntry.Reset();
                            reglementEntry."Journal Template Name" := 'REGLEMENT';
                            reglementEntry.Validate("Journal Template Name");
                            reglementEntry."Journal Batch Name" := Caisse."Code caisse";
                            reglementEntry.Validate("Journal Batch Name");
                            reglementEntry."Line No." := LineNo;
                            reglementEntry."Posting Date" := WorkDate;
                            reglementEntry.Validate("Posting Date");
                            reglementEntry."Document Type" := reglementEntry."Document Type"::Invoice;
                            reglementEntry.Validate("Document Type");
                            reglementEntry."Document No." := 'Depot' + rec."N°";
                            reglementEntry.Validate("Document No.");
                            reglementEntry."Account Type" := reglementEntry."Account Type"::"Customer";
                            reglementEntry.Validate("Account Type");
                            reglementEntry."Account No." := rec."N° client";
                            reglementEntry.Validate("Account No.");
                            reglementEntry.Description := 'Annulation Dépôt du client: ' + rec."Nom du client";
                            reglementEntry."Bal. Account Type" := reglementEntry."Bal. Account Type"::"Bank Account";
                            reglementEntry."Bal. Account No." := Caisse."Code caisse";
                            reglementEntry.Validate("Bal. Account No.");

                            reglementEntry.Amount := rec.Montant;
                            reglementEntry."Amount (LCY)" := rec."Montant";
                            reglementEntry.Validate(Amount);
                            reglementEntry."Debit Amount" := rec."Montant";
                            reglementEntry.Validate("Debit Amount");
                            reglementEntry.Insert();


                            reglementEntry3.Reset();
                            reglementEntry3.SetRange("Journal Template Name", 'REGLEMENT');
                            reglementEntry3.SetRange("Journal Batch Name", Caisse."Code caisse");
                            reglementEntry3.SetRange("Document No.", 'Depot' + rec."N°");
                            if (reglementEntry3.FindFirst()) then begin
                                Hide := true;
                                postLedger.OnBeforeCode(reglementEntry3, Hide);
                                CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", reglementEntry3);
                            end;
                        end;
                    end;*/
                end;
            }
        }

    }

    trigger OnOpenPage()
    var
    begin
        // Date := WorkDate;
        // Heure := Time;
        // "User Id" := UserId;
        Caisse.Reset();
        Caisse.SetRange("User ID", UserId);
        Caisse.FindFirst();
        //     "Code caisse" := Caisse."Code caisse";
        // CurrPage.Update();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        Caisse.Reset();
        rec."User ID" := UserId;
        Caisse.SetRange("User ID", UserId);
        if (caisse.FindFirst()) then
            rec."Code Caisse" := caisse."Code caisse";
        rec.Heure := time;
        rec.Date := WorkDate;
        rec."Mode de paiement" := 'ESPÈCES'
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
        usep: Record 91;



    begin
        // usep.get(UserId);
        // if usep.Director or usep.CorrectioDepot then
        //     CurrPage.Close();
        // exit;



        if (rec.Montant >= 0) and (rec."Mode de paiement" = 'ESPÈCES') then begin
            if rec.validated = false then begin
                if Confirm('Vous n''avez pas validé le dépôt! Si vous sortez, le dépot sera supprimé. Voulez-vous sortir?') then begin
                    if rec."N°" <> '' then rec.Delete();
                    CurrPage.Close();
                end else
                    Error('Veuillez valider le dépôt');
            end;
        end
        //  silue samuel 07/03/2025 else begin

        //     if (rec.validated = false) then
        //         if (rec.DemandeApprobation = false) then begin

        //             Error('Veuillez le soumettre a approbation');
        //         end
        //         else
        //             Error('Veuillez valider le dépôt');

        // end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
    begin
        if Rec.validated then
            Error('Vous ne pouvez-pas supprimer un dépôt validé');

    end;

    var
        Caisse: Record Caisse;
        hide: Boolean;
        postLedger: Codeunit 70000;
        confirmSave: TextConst ENU = 'Would you like to save this transaction ?', FRA = 'Souhaitez-vous enregistrer cette transaction ?';
        cancelSave: TextConst ENU = 'Would you like to cancel this transaction ?', FRA = 'Souhaitez-vous annuler cette transaction ?';
}