document.addEventListener("DOMContentLoaded", function () {
  const cards = document.querySelectorAll(".uploadtrigger");

  // open native file picker when the card is clicked
  cards?.forEach(card => {
    card.addEventListener("click", function () {
      const target = this.getAttribute("data-target");
      const fileInput = document.getElementById(target);
      if (!fileInput) return;
      //fileInput.value = ""; // retrigger for same file
      fileInput.click();
    });
  });

  // ensure a per-input gallery exists
 function ensureGallery(inputId, triggerEl) {
  let gallery = document.querySelector(`.apartment-gallery[data-for="${inputId}"]`);
  if (!gallery) {
    gallery = document.createElement('div');
    gallery.className = 'apartment-gallery';
    gallery.setAttribute('data-for', inputId);

    const copy = (attr, as) => {
      const v = triggerEl?.getAttribute(attr);
      if (v) gallery.setAttribute(as || attr, v);
    };

    copy('data-action');
    copy('data-delete-action', 'data-action');
    copy('data-field');
    copy('data-table');
    copy('data-objectid');

    triggerEl?.parentElement
      ? triggerEl.parentElement.appendChild(gallery)
      : document.body.appendChild(gallery);
  }

  return gallery;
}


  // build one gallery item
  function createGalleryItem({ gallery, filename }) {
    const wrap = document.createElement('div');
    wrap.className = 'apartment-image';

    const img = document.createElement('div');
    img.className = 'upload-preview';
    img.style.maxWidth = '140px';
    img.style.display = 'none';

    const other=document.createElement('a');
      other.className = 'upload-preview';
    other.style.maxWidth = '140px';
    other.style.display = 'none';

    const progressOuter = document.createElement('div');
    progressOuter.className = 'progress mt-2';
    progressOuter.style.height = '20px';

    const bar = document.createElement('div');
    bar.className = 'progress-bar';
    bar.style.width = '0%';
    bar.textContent = '0%';

    progressOuter.appendChild(bar);

    const delBtn = document.createElement('button');
    delBtn.type = 'button';
    delBtn.className = 'btn btn-sm btn-outline-danger mt-2 delete-btn-multiple';
    delBtn.innerHTML = '<i class="fa-solid fa-trash"></i>';
    delBtn.style.display = 'none';

    wrap.appendChild(img);
    wrap.appendChild(other);
    wrap.appendChild(progressOuter);
    wrap.appendChild(delBtn);
    gallery.appendChild(wrap);

    return { wrap, bar, img, delBtn,other };
  }
function uploadOneMultiple({
  file,
  endpoint,
  fieldName,
  securityID,
  table,
  objectID,
  bar = null,
  preview = null,
  other=null,
  wrap
}) {
  return new Promise((resolve) => {
    const formData = new FormData();
    formData.append(fieldName, file);
    formData.append("field", fieldName);

    if (securityID) formData.append("SecurityID", securityID);
    if (table) formData.append("table", table);
    if (objectID) formData.append("objectID", objectID);

    // Preview local image instantly
    if (file.type.startsWith("image/") && preview && preview.tagName === "IMG") {
      const reader = new FileReader();
      reader.onload = (ev) => {
        preview.src = ev.target.result;
        preview.style.display = "block";
      };
      reader.readAsDataURL(file);
    }

    const xhr = new XMLHttpRequest();
    xhr.open("POST", endpoint, true);
    xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");

    // Upload progress
    xhr.upload.onprogress = function (ev) {
      if (ev.lengthComputable && bar) {
        const pct = Math.round((ev.loaded / ev.total) * 100);
        bar.style.width = pct + "%";
        bar.textContent = pct + "%";
      }
    };

    xhr.onload = function () {
      let payload = {};
      let ok = false;

      try {
        payload = JSON.parse(xhr.responseText || "{}");
        ok = xhr.status >= 200 && xhr.status < 300 && payload.ok;
      } catch (e) {}

      if (ok) {
        console.log(file.type.startsWith('image/'));
        if (file.type.startsWith('image/')) {
         
        // Replace preview with server image URL
        if (preview && payload.url) {
          const imgtag=document.createElement('img');
          imgtag.src = payload.url;
          preview.appendChild(imgtag);
          preview.style.display = "block";
        }
      }else{
          const atag=document.createElement('a');
          atag.href = payload.url;
          atag.target = '_blank';
    atag.textContent = 'View pdf';
          preview.appendChild(atag);
          preview.style.display = "block";
      }
      const form = document.querySelector('form');
      const input = document.createElement('input');
  input.type = 'hidden';
  input.name = 'Attachment[]';
  input.value = payload.id;
  form.appendChild(input);
          $("#nav-bilder-tab").addClass("filesfilled");
        resolve({ ok: true, payload });
      } else {
        // Reset on failure
        if (preview && preview.tagName === "IMG") {
          preview.src = "";
          preview.style.display = "none";
        }
        if (bar) {
          bar.style.width = "0%";
          bar.textContent = "";
        }

        Swal.fire({
          title: "Error",
          text: payload.error || payload.message || "Upload failed",
          icon: "error",
          confirmButtonText: "OK",
        });

        resolve({ ok: false, payload });
      }
    };

    xhr.onerror = function () {
      Swal.fire({
        title: "Error",
        text: "Network error during upload",
        icon: "error",
        confirmButtonText: "OK"
      });

      resolve({ ok: false, payload: {} });
    };

    xhr.send(formData);
  });
}

  // upload one file
  function uploadOne({ file, endpoint, fieldName, securityID, table, objectID, bar, preview,uiWrap,inputId,label,labelValue }) {
    return new Promise((resolve) => {
      const formData = new FormData();
      formData.append(fieldName, file);
      formData.append('field', fieldName);
      if (securityID) formData.append('SecurityID', securityID);
      if (table)      formData.append('table', table);
      if (objectID)   formData.append('objectID', objectID);

      if (file.type.startsWith('image/') && preview && preview.tagName === 'IMG') {
        const reader = new FileReader();
        reader.onload = ev => { preview.src = ev.target.result; preview.style.display = 'block'; };
        reader.readAsDataURL(file);
      }

      const xhr = new XMLHttpRequest();
      xhr.open('POST', endpoint, true);
      xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');

      xhr.upload.onprogress = function (ev) {
        if (ev.lengthComputable && bar) {
          const pct = Math.round((ev.loaded / ev.total) * 100);
          bar.style.width = pct + '%';
          bar.textContent = pct + '%';
        }
      };

      xhr.onload = function () {
        let ok = false, payload = {};
        try { payload = JSON.parse(xhr.responseText || '{}'); ok = (xhr.status >= 200 && xhr.status < 300 && payload.ok); } catch (e) {}
        if (ok) {
          if (file.type.startsWith('image/')) {
           
            if (preview && preview.tagName === 'IMG' && payload.url) {
              uiWrap.querySelector('.image-preview').style.display = 'block';
              preview.src = payload.url;
              preview.style.display = 'block';
            }
          } else if (preview) {
            uiWrap.querySelector('.image-preview').style.display = 'block';
            if (preview.tagName !== 'A') {
              const a = document.createElement('a');
              a.className = 'upload-preview';
              a.target = '_blank';
              a.textContent = 'View';
              preview.replaceWith(a);
              preview = a;
            }
            if (payload.url) {
             
              preview.href = payload.url;
              preview.style.display = 'inline-block';
            }
          }
          const idHolder = document.getElementById('AjaxFileUploadId');
          if (idHolder && payload.id) idHolder.value = payload.id;
            if(inputId=='VideoIDInput')
              $("#nav-video-tab").addClass("filesfilled");
            else if(inputId=='DocumentIDInput')
              $("#nav-document-tab").addClass("filesfilled");
            else
              $("#nav-grund-tab").addClass("filesfilled");
          resolve({ ok: true, payload });
        } else {
          $("#" + inputId).val('');
          preview.src='';
          preview.style.display = 'none';
          if(label){
          label.textContent = labelValue;
          }
          if(uiWrap){
          uiWrap.querySelector('.progress-bar').style.width = '0%';
          uiWrap.querySelector('.progress-bar').textContent = '';
          }
          Swal.fire({
						title: 'Error',
						text: payload.error || payload.message || 'Upload failed',
						icon: 'error',
						confirmButtonText: 'OK'
					});
          resolve({ ok: false, payload });
        }
      };

      xhr.onerror = function () { 
        Swal.fire({
          title: 'Error',
          text: 'Network error during upload',
          icon: 'error',
          confirmButtonText: 'OK'
        });
       
        resolve({ ok: false, payload: {} }); };
      xhr.send(formData);
    });
  }

  // on file selection
  document.querySelectorAll(".inputFileHidden").forEach(input => {
    input.addEventListener("change", async function () {
      const files = Array.from(this.files || []);
     
      if (!files.length) return;

      const securityID = document.querySelector('input[name="SecurityID"]')?.value || '';
      const inputId    = this.id;

      const trigger   = document.querySelector(`.uploadtrigger[data-target="${inputId}"]`);
      const endpoint  = trigger?.getAttribute('data-action');
      const fieldName = trigger?.getAttribute('data-field') || this.name;
      const table     = trigger?.getAttribute('data-table') || '';
      const label     = trigger?.querySelector('.file-name');
      let labelValue='';
      if(label){
       labelValue=label.textContent;
      }

      if (!endpoint) { console.warn('No data-action endpoint for', inputId); return; }
      if (label) { label.textContent = files.length === 1 ? files[0].name : `${files.length} Dateien ausgewählt`; }

      // object ID
      let objectID = 0;
      const objIdEl = document.getElementById('ObjectIDModal');
      if (objIdEl) objectID = objIdEl.value;

      const isMulti = this.hasAttribute('multiple');

      if (isMulti) {
        
        // Always use a gallery for multi
        const gallery = ensureGallery(inputId, trigger);
        // inherit action/field/table/objectid if gallery created
        const deleteAction = gallery.getAttribute('data-delete-action') || trigger?.getAttribute('data-delete-action') || '';
        const galleryField = gallery.getAttribute('data-field') || fieldName;
        const galleryTable = gallery.getAttribute('data-table') || table;
        const galleryObjId = gallery.getAttribute('data-objectid') || objectID;

        // sequential uploads
        for (const f of files) {
          const { wrap, bar, img, delBtn,other } = createGalleryItem({ gallery, filename: f.name });
          const result = await uploadOneMultiple({
            file: f,
            endpoint,
            fieldName: galleryField,
            securityID,
            table: galleryTable,
            objectID: galleryObjId,
            bar,
            preview: img,
            otherpreview: other,
            wrap
          });

          if (result.ok) {
            const id  = result.payload?.id || '';
            const url = result.payload?.url || '';
            delBtn.dataset.field    = galleryField;
            delBtn.dataset.objectid = galleryObjId;
            delBtn.dataset.fileid   = id;
            delBtn.dataset.action   = deleteAction;
            delBtn.dataset.table    = galleryTable;
            delBtn.style.display    = 'inline-block';

            if (url) {
              img.style.cursor = 'pointer';
              img.addEventListener('click', () => window.open(url, '_blank'));
            }
          } else {
            wrap.remove();
          }
        }
      } else {
        // Single-file: your existing single preview UI
        const uiWrap = document.querySelector(`.upload-ui[data-for="${inputId}"]`);
        const progressmaindiv = uiWrap?.querySelector('.progress') || null;
        const bar    = uiWrap?.querySelector('.progress-bar') || null;
      if (progressmaindiv) {
       
    progressmaindiv.style.display = "block";  // show the progress bar
}
        let preview  = uiWrap?.querySelector('.upload-preview') || null;
        await uploadOne({ file: files[0], endpoint, fieldName, securityID, table, objectID, bar, preview,uiWrap,inputId,label,labelValue });
      }

   
    });
  });
});
jQuery(document).ready(function($) {
    $('.dashboardwrapper').on('click', '.delete-btn', function(e) {
        e.preventDefault();
    Swal.fire({
      title: 'Are you sure?',
      text: "You won't be able to delete this!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
      if (result.isConfirmed) {
        var btn = jQuery(this);
        var field = btn.data('field');
        var forInput = btn.data('for');
        var fileslot = btn.closest('.file-slot');
        var objectID = btn.data('objectid');
        var fileID = btn.data('fileid') ? btn.data('fileid') : 'None';
        var action = btn.data('action');
        var table = btn.data('table');
        var securityID = jQuery('input[name="SecurityID"]').val();
    
        jQuery.ajax({
            url: action + '?objectId=' + objectID,
            method: 'POST',
            data: {
                field: field,
                objectId: objectID,
                table: table,
                fileID: fileID,
                SecurityID: securityID
            },
            success: function(res) {
                if (res.ok) {
                  Swal.fire({
                    title: 'Success',
                    text: 'File has been deleted',
                    icon: 'success',
                    confirmButtonText: 'OK'
                  });
                  if(field=='GrundID')
                    $("#nav-grund-tab").removeClass("filesfilled");
                  else if(field=='DocumentID')
                    $("#nav-document-tab").removeClass("filesfilled");
                  else
                    $("#nav-video-tab").removeClass("filesfilled");
                    // update UI: remove preview, disable button
                    fileslot.find('.upload-preview').hide(); 
                    fileslot.find('.delete-btn').hide();
                    
                    const uiWrap2 = document.querySelector(`.upload-ui[data-for="${forInput}"]`);
                    uiWrap2.querySelector('.image-preview').style.display = 'none'; 
                } else {
                  Swal.fire({
                    title: 'Error',
                    text: res.error || "Fehler beim Löschen",
                    icon: 'error',
                    confirmButtonText: 'OK'
                  });
                }
            },
            error: function(xhr) {
              Swal.fire({
                title: 'Error',
                text: 'Serverfehler: ' + xhr.status,
                icon: 'error',
                confirmButtonText: 'OK'
              });
            }
        });
      }
    })
    
     
    });

    $(document).on('click', '.delete-btn-multiple', function (e) {
      e.preventDefault();
      Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to restore this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
      }).then((result) => {
        if (result.isConfirmed) {
          const $btn = $(this);
          const $gallery = $btn.closest('.apartment-gallery');
          const objectID = $gallery.data('objectid') || $btn.data('objectid');       // read from wrapper
          const fileID = $btn.data('fileid');
          const field = $btn.data('field') || 'Bilder';
          const action = $btn.data('action');
          const securityID = $('input[name="SecurityID"]').val();
          const $imageWrap = $btn.closest('.apartment-image');
        
          $.ajax({
            url: action + '?objectId=' + encodeURIComponent(objectID),
            method: 'POST',
            dataType: 'json',
            data: { field, objectId: objectID, fileID: fileID, SecurityID: securityID },
            success: function (res) {
              if (res && res.ok) {
                document
        .querySelectorAll(`input[name="Attachment[]"][value="${fileID}"]`)
        .forEach(el => el.remove());
                $imageWrap.remove();

                if ($gallery.find('.apartment-image').length === 0) {
                  $gallery.replaceWith('<img src="" class="upload-preview" style="display:none" alt="">');
                }
                if($(".delete-btn-multiple").length==0)
                $("#nav-bilder-tab").removeClass("filesfilled");
              
              } else {
                Swal.fire({
                  title: '',
                  text: (res && (res.message || res.error)) || 'Fehler beim Löschen',
                  icon: 'error',
                  confirmButtonText: 'OK'
                });
              
              }
            },
            error: xhr => Swal.fire({
              title: 'Error',
              text: 'Serverfehler: ' + xhr.status,
              icon: 'error',
              confirmButtonText: 'OK'
            })
          });
        }
      })
    
     
    });
    

});



